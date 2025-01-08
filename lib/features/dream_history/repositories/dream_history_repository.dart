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

  Future<List<DreamHistoryModel>> getDreamHistory(String userId,
      {int? lastDocumentIndex}) async {
    try {
      debugPrint(
          'Fetching dreams for userId: $userId, lastIndex: $lastDocumentIndex');

      var query = _firestore
          .collection('dreams')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(pageSize);

      if (lastDocumentIndex != null) {
        final lastDocSnapshot = await _firestore
            .collection('dreams')
            .where('userId', isEqualTo: userId)
            .orderBy('createdAt', descending: true)
            .limit(1)
            .get();

        if (lastDocSnapshot.docs.isNotEmpty) {
          final lastDoc = lastDocSnapshot.docs.last;
          query = query.startAfter(
              [lastDoc['createdAt']]); // Use the 'createdAt' field value
        }
      }
      print('Query: ${query.toString()}');
      print(lastDocumentIndex);

      final snapshot = await query.get();
      debugPrint('Found ${snapshot.docs.length} dreams');

      return snapshot.docs.map((doc) {
        final data = doc.data();

        // Handle different date formats
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
    } catch (e, stackTrace) {
      debugPrint('Error in getDreamHistory: $e');
      debugPrint('StackTrace: $stackTrace');
      debugPrint('UserId that caused error: $userId');
      throw Exception('Failed to fetch dream history');
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
