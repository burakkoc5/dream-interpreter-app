import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StatsRepository {
  final FirebaseFirestore _firestore;

  StatsRepository(this._firestore);

  DateTime? _parseDate(dynamic createdAt) {
    if (createdAt == null) return null;

    if (createdAt is Timestamp) {
      return createdAt.toDate();
    } else if (createdAt is String) {
      return DateTime.tryParse(createdAt);
    }
    return null;
  }

  Stream<Map<String, dynamic>> getUserStats(String userId) {
    debugPrint('Fetching stats for userId: $userId');

    // Combine dreams and streak data streams
    final dreamsStream = _firestore
        .collection('dreams')
        .where('userId', isEqualTo: userId)
        .snapshots();

    final streakStream =
        _firestore.collection('streaks').doc(userId).snapshots();

    return Rx.combineLatest2(
      dreamsStream,
      streakStream,
      (QuerySnapshot dreamsSnapshot, DocumentSnapshot streakSnapshot) {
        debugPrint('Number of documents: ${dreamsSnapshot.docs.length}');

        // Get streak data
        final streakData = streakSnapshot.data() as Map<String, dynamic>?;
        final currentStreak = streakData?['currentStreak'] ?? 0;
        final longestStreak = streakData?['longestStreak'] ?? 0;

        if (dreamsSnapshot.docs.isEmpty) {
          return {
            'totalDreams': 0,
            'weeklyDreams': 0,
            'completionRate': 0.0,
            'currentStreak': currentStreak,
            'longestStreak': longestStreak,
          };
        }

        final dreams = dreamsSnapshot.docs;
        final now = DateTime.now();
        final weekAgo = now.subtract(const Duration(days: 7));

        try {
          int totalDreams = dreams.length;
          int weeklyDreams = dreams.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final createdAt = data['createdAt'];
            final dreamDate = _parseDate(createdAt);
            return dreamDate != null && dreamDate.isAfter(weekAgo);
          }).length;

          int dreamsWithInterpretation = dreams.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final interpretation = data['interpretation'];
            return interpretation != null &&
                interpretation is String &&
                interpretation.trim().isNotEmpty;
          }).length;

          double completionRate =
              totalDreams > 0 ? dreamsWithInterpretation / totalDreams : 0.0;

          completionRate = double.parse(completionRate.toStringAsFixed(2));

          debugPrint('Stats calculated successfully:');
          debugPrint('Total dreams: $totalDreams');
          debugPrint('Weekly dreams: $weeklyDreams');
          debugPrint('Completion rate: $completionRate');
          debugPrint('Current streak: $currentStreak');
          debugPrint('Longest streak: $longestStreak');

          return {
            'totalDreams': totalDreams,
            'weeklyDreams': weeklyDreams,
            'completionRate': completionRate,
            'currentStreak': currentStreak,
            'longestStreak': longestStreak,
          };
        } catch (e) {
          debugPrint('Error calculating stats: $e');
          return {
            'totalDreams': 0,
            'weeklyDreams': 0,
            'completionRate': 0.0,
            'currentStreak': currentStreak,
            'longestStreak': longestStreak,
            'error': e.toString(),
          };
        }
      },
    );
  }
}
