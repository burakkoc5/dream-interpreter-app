import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: Not working properly. Fix this issue.
@injectable
class DreamHistoryRepository {
  final FirebaseFirestore _firestore;

  DreamHistoryRepository(this._firestore);

  static const int pageSize = 10;

  Future<Map<String, dynamic>> getDreamHistory(
    String userId, {
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      var query = _firestore
          .collection('dreams')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: false)
          .limit(pageSize);
      print('Last document: ${lastDocument?.id}');
      print('userId on repository: $userId');

      print('Fetching dream history query ready...');

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      print('Fetching dream history...');

      final snapshot = await query.get();
      print('Fetched ${snapshot.docs.length} dreams');

      if (snapshot.docs.isEmpty) {
        print('No dreams found');
        return {
          'dreams': [],
          'lastDocument': lastDocument,
          'isNewData': false, // No new data
        };
      }

      print('Fetched ${snapshot.docs.length} dreams');

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
      await _firestore.collection('dreams').doc(dreamId).delete();
      debugPrint('Successfully deleted dream with ID: $dreamId');
    } catch (e, stackTrace) {
      debugPrint('Error deleting dream: $e');
      debugPrint('StackTrace: $stackTrace');
      throw Exception('Failed to delete dream: $e');
    }
  }
}
