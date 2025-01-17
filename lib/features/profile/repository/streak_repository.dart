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
    final doc = await _streaksCollection.doc(userId).get();

    if (!doc.exists) {
      // For first dream, set streak to 1
      print('Setting streak to 1 for user $userId');
      await _streaksCollection.doc(userId).set({
        'userId': userId,
        'currentStreak': 1,
        'longestStreak': 1,
        'lastDreamDate': now.toIso8601String(),
        'hasLoggedDreamToday': true,
      });
      return;
    }

    final streak = StreakModel.fromJson(doc.data()!..['userId'] = userId);
    final lastDreamDate = streak.lastDreamDate;

    // If already logged today, do nothing
    print('Streak: ${streak.toJson()}');
    if (streak.hasLoggedDreamToday) return;

    // Check if the last dream was logged yesterday
    print('Last dream date: $lastDreamDate');
    final isYesterday = lastDreamDate.difference(now).inDays.abs() == 1;
    final isToday = lastDreamDate.day == now.day &&
        lastDreamDate.month == now.month &&
        lastDreamDate.year == now.year;

    int newCurrentStreak = streak.currentStreak;
    if (isToday) {
      // Already counted for today
      newCurrentStreak = streak.currentStreak;
    } else if (isYesterday) {
      // Continuous streak
      newCurrentStreak = streak.currentStreak + 1;
    } else {
      // Streak broken
      newCurrentStreak = 1;
    }

    final newLongestStreak = newCurrentStreak > streak.longestStreak
        ? newCurrentStreak
        : streak.longestStreak;

    await _streaksCollection.doc(userId).update({
      'currentStreak': newCurrentStreak,
      'longestStreak': newLongestStreak,
      'lastDreamDate': now.toIso8601String(),
      'hasLoggedDreamToday': true,
    });
  }

  Future<void> resetDailyFlag() async {
    final batch = _firestore.batch();
    final snapshots = await _streaksCollection.get();

    for (var doc in snapshots.docs) {
      batch.update(doc.reference, {'hasLoggedDreamToday': false});
    }

    await batch.commit();
  }
}
