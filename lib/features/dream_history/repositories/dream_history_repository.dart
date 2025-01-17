import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dream/features/dream_entry/services/local_storage_service.dart';

@injectable
class DreamHistoryRepository {
  final FirebaseFirestore _firestore;
  final LocalStorageService _localStorageService;

  DreamHistoryRepository(this._firestore, this._localStorageService);

  static const int pageSize = 10;

  Future<Map<String, dynamic>> getDreamHistory(
    String userId, {
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      var query = _firestore
          .collection('dreams')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(pageSize);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        return {
          'dreams': [],
          'lastDocument': lastDocument,
          'isNewData': false, // No new data
        };
      }

      final dreams = snapshot.docs.map((doc) {
        final data = doc.data();

        DateTime createdAt;
        final createdAtData = data['createdAt'];
        if (createdAtData is Timestamp) {
          createdAt = createdAtData.toDate();
        } else if (createdAtData is String) {
          createdAt = DateTime.parse(createdAtData);
        } else {
          createdAt = DateTime.now(); // Fallback value
          debugPrint(
              'Unexpected createdAt format for dream ${doc.id}: $createdAtData');
        }
        return DreamHistoryModel(
          id: doc.id,
          userId: data['userId'] as String,
          content: data['content'] as String,
          createdAt: createdAt,
          interpretation: data['interpretation'] as String,
          title: data['title'] as String,
          moodRating: data['moodRating'] as int,
          tags: (data['tags'] as List<dynamic>?)?.cast<String>() ?? [],
          isFavourite: data['isFavourite'] as bool? ?? false,
        );
      }).toList();

      final lastFetchedDocument = snapshot.docs.last;

      return {
        'dreams': dreams,
        'lastDocument': lastFetchedDocument,
        'isNewData': true, // New data fetched
      };
    } catch (e) {
      throw Exception('Failed to fetch dream history: $e');
    }
  }

  Future<void> deleteDream(String dreamId) async {
    try {
      debugPrint('Attempting to delete dream with ID: $dreamId');

      // First get the document to verify ownership
      final docSnapshot =
          await _firestore.collection('dreams').doc(dreamId).get();

      if (!docSnapshot.exists) {
        throw Exception('Dream not found');
      }

      final data = docSnapshot.data();
      if (data == null) {
        throw Exception('Dream data is null');
      }

      // Get the current user's ID
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently signed in');
      }

      // Verify ownership
      if (data['userId'] != currentUser.uid) {
        throw Exception('You do not have permission to delete this dream');
      }

      // Check if there's a draft and if it matches the dream being deleted
      final draft = await _localStorageService.getDraft();
      if (draft != null && draft.id == dreamId) {
        await _localStorageService.clearDraft();
        debugPrint('Cleared matching draft from local storage');
      }

      // If we get here, the user owns the document, so we can delete it
      await _firestore.collection('dreams').doc(dreamId).delete();
      debugPrint('Successfully deleted dream with ID: $dreamId');
    } catch (e, stackTrace) {
      debugPrint('Error deleting dream: $e');
      debugPrint('StackTrace: $stackTrace');
      throw Exception('Failed to delete dream: $e');
    }
  }

  Future<void> updateDream(DreamHistoryModel dream) async {
    try {
      debugPrint('Attempting to update dream with ID: ${dream.id}');

      // Get the current user's ID
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently signed in');
      }

      // Verify ownership
      if (dream.userId != currentUser.uid) {
        throw Exception('You do not have permission to update this dream');
      }

      // Update the document
      await _firestore
          .collection('dreams')
          .doc(dream.id)
          .update(dream.toJson());
      debugPrint('Successfully updated dream with ID: ${dream.id}');
    } catch (e, stackTrace) {
      debugPrint('Error updating dream: $e');
      debugPrint('StackTrace: $stackTrace');
      throw Exception('Failed to update dream: $e');
    }
  }
}
