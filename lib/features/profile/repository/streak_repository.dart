import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/features/profile/models/streak_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StreakRepository {
  final FirebaseFirestore _firestore;

  StreakRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _streaksCollection =>
      _firestore.collection('streaks');

  Stream<StreakModel> watchUserStreak(String userId) {
    return _streaksCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) {
        return StreakModel.initial(userId);
      }
      return StreakModel.fromJson(doc.data()!..['userId'] = userId);
    });
  }

  Future<void> updateStreak(String userId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final doc = await _streaksCollection.doc(userId).get();

    if (!doc.exists) {
      // First dream ever, start streak at 1
      debugPrint('First dream ever, setting streak to 1 for user $userId');
      await _streaksCollection.doc(userId).set({
        'userId': userId,
        'currentStreak': 1,
        'longestStreak': 1,
        'lastDreamDate': today.toIso8601String(),
        'hasLoggedDreamToday': true,
      });
      return;
    }

    var streak = StreakModel.fromJson(doc.data()!..['userId'] = userId);
    final lastDreamDate = DateTime(
      streak.lastDreamDate.year,
      streak.lastDreamDate.month,
      streak.lastDreamDate.day,
    );

    debugPrint('Current streak: ${streak.currentStreak}');
    debugPrint('Last dream date: $lastDreamDate');
    debugPrint('Today: $today');

    // Reset hasLoggedDreamToday if it's a new day
    if (lastDreamDate != today && streak.hasLoggedDreamToday) {
      debugPrint('New day detected, resetting hasLoggedDreamToday flag');
      streak = streak.copyWith(hasLoggedDreamToday: false);
    }

    // If already logged today, keep current streak
    if (streak.hasLoggedDreamToday) {
      debugPrint(
          'Already logged dream today, keeping streak at: ${streak.currentStreak}');
      return;
    }

    int newCurrentStreak;
    if (lastDreamDate == today) {
      // Another dream today, keep streak
      newCurrentStreak = streak.currentStreak;
      debugPrint('Another dream today, keeping streak at: $newCurrentStreak');
    } else if (lastDreamDate.add(const Duration(days: 1)) == today ||
        lastDreamDate == today.subtract(const Duration(days: 1))) {
      // Dream logged on consecutive day (checking both forward and backward to handle timezone edge cases)
      newCurrentStreak = streak.currentStreak + 1;
      debugPrint(
          'Dream logged on consecutive day, incrementing streak to: $newCurrentStreak');
    } else if (today.difference(lastDreamDate).inDays > 1) {
      // Missed a day, reset streak
      newCurrentStreak = 1;
      debugPrint('Missed a day, resetting streak to: $newCurrentStreak');
    } else {
      // Any other case (shouldn't happen), start new streak
      newCurrentStreak = 1;
      debugPrint('Starting new streak: $newCurrentStreak');
    }

    final newLongestStreak = newCurrentStreak > streak.longestStreak
        ? newCurrentStreak
        : streak.longestStreak;

    debugPrint(
        'Updating streak - Current: $newCurrentStreak, Longest: $newLongestStreak');
    await _streaksCollection.doc(userId).update({
      'currentStreak': newCurrentStreak,
      'longestStreak': newLongestStreak,
      'lastDreamDate': today.toIso8601String(),
      'hasLoggedDreamToday': true,
    });
  }

  Future<void> resetDailyFlag() async {
    final batch = _firestore.batch();
    final snapshots = await _streaksCollection.get();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (var doc in snapshots.docs) {
      final data = doc.data();
      final lastDreamDate = DateTime.parse(data['lastDreamDate'] as String);
      final lastDate = DateTime(
        lastDreamDate.year,
        lastDreamDate.month,
        lastDreamDate.day,
      );

      if (today.difference(lastDate).inDays > 1) {
        // More than one day has passed, reset streak
        debugPrint('Resetting streak for user ${doc.id} - missed a day');
        batch.update(doc.reference, {
          'currentStreak': 0,
          'hasLoggedDreamToday': false,
        });
      } else {
        // Just reset the daily flag for today
        batch.update(doc.reference, {'hasLoggedDreamToday': false});
      }
    }

    await batch.commit();
  }
}
