import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/features/profile/models/streak_model.dart';

class StreakRepository {
  final FirebaseFirestore _firestore;

  StreakRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

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
      print('First dream ever, setting streak to 1 for user $userId');
      await _streaksCollection.doc(userId).set({
        'userId': userId,
        'currentStreak': 1,
        'longestStreak': 1,
        'lastDreamDate': today.toIso8601String(),
        'hasLoggedDreamToday': true,
      });
      return;
    }

    final streak = StreakModel.fromJson(doc.data()!..['userId'] = userId);
    final lastDreamDate = DateTime(
      streak.lastDreamDate.year,
      streak.lastDreamDate.month,
      streak.lastDreamDate.day,
    );

    print('Current streak: ${streak.currentStreak}');
    print('Last dream date: $lastDreamDate');
    print('Today: $today');

    // If already logged today, keep current streak
    if (streak.hasLoggedDreamToday) {
      print(
          'Already logged dream today, keeping streak at: ${streak.currentStreak}');
      return;
    }

    int newCurrentStreak;
    if (lastDreamDate == today) {
      // Another dream today, keep streak
      newCurrentStreak = streak.currentStreak;
      print('Another dream today, keeping streak at: $newCurrentStreak');
    } else if (lastDreamDate.add(const Duration(days: 1)) == today) {
      // Dream logged on consecutive day, increment streak
      newCurrentStreak = streak.currentStreak + 1;
      print(
          'Dream logged on consecutive day, incrementing streak to: $newCurrentStreak');
    } else if (today.difference(lastDreamDate).inDays > 1) {
      // Missed a day, reset streak
      newCurrentStreak = 1;
      print('Missed a day, resetting streak to: $newCurrentStreak');
    } else {
      // Any other case (shouldn't happen), start new streak
      newCurrentStreak = 1;
      print('Starting new streak: $newCurrentStreak');
    }

    final newLongestStreak = newCurrentStreak > streak.longestStreak
        ? newCurrentStreak
        : streak.longestStreak;

    print(
        'Updating streak - Current: $newCurrentStreak, Longest: $newLongestStreak');
    await _streaksCollection.doc(userId).update({
      'currentStreak': newCurrentStreak,
      'longestStreak': newLongestStreak,
      'lastDreamDate': today.toIso8601String(), // Store only the date part
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
        print('Resetting streak for user ${doc.id} - missed a day');
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
