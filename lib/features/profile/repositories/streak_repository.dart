import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/features/profile/models/streak_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dream/core/network/network_retry.dart';
import 'package:dream/core/services/logging_service.dart';

@injectable
class StreakRepository {
  final FirebaseFirestore _firestore;
  final NetworkRetry _networkRetry;
  final LoggingService _logger;

  StreakRepository(
    this._firestore,
    LoggingService logger,
  )   : _logger = logger,
        _networkRetry = NetworkRetry(logger);

  CollectionReference<Map<String, dynamic>> get _streaksCollection =>
      _firestore.collection('streaks');

  Stream<StreakModel> watchUserStreak(String userId) {
    return _streaksCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) {
        _logger.log(
          'No streak found for user, creating initial streak',
          level: LogLevel.info,
          additionalData: {'userId': userId},
        );
        return StreakModel.initial(userId);
      }
      return StreakModel.fromJson(doc.data()!..['userId'] = userId);
    });
  }

  Future<void> updateStreak(String userId) async {
    await _networkRetry.retry(
      () async {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final doc = await _streaksCollection.doc(userId).get();

        if (!doc.exists) {
          _logger.log(
            'First dream ever, setting streak to 1',
            level: LogLevel.info,
            additionalData: {'userId': userId},
          );
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

        _logger.log(
          'Processing streak update',
          level: LogLevel.info,
          additionalData: {
            'userId': userId,
            'currentStreak': streak.currentStreak,
            'lastDreamDate': lastDreamDate.toIso8601String(),
            'today': today.toIso8601String(),
          },
        );

        if (lastDreamDate != today && streak.hasLoggedDreamToday) {
          _logger.log(
            'New day detected, resetting hasLoggedDreamToday flag',
            level: LogLevel.info,
          );
          streak = streak.copyWith(hasLoggedDreamToday: false);
        }

        if (streak.hasLoggedDreamToday) {
          _logger.log(
            'Already logged dream today, keeping current streak',
            level: LogLevel.info,
            additionalData: {'currentStreak': streak.currentStreak},
          );
          return;
        }

        int newCurrentStreak;
        if (lastDreamDate == today) {
          newCurrentStreak = streak.currentStreak;
          _logger.log(
            'Another dream today, keeping streak',
            level: LogLevel.info,
            additionalData: {'streak': newCurrentStreak},
          );
        } else if (lastDreamDate.add(const Duration(days: 1)) == today ||
            lastDreamDate == today.subtract(const Duration(days: 1))) {
          newCurrentStreak = streak.currentStreak + 1;
          _logger.log(
            'Dream logged on consecutive day',
            level: LogLevel.info,
            additionalData: {'newStreak': newCurrentStreak},
          );
        } else if (today.difference(lastDreamDate).inDays > 1) {
          newCurrentStreak = 1;
          _logger.log(
            'Missed a day, resetting streak',
            level: LogLevel.info,
          );
        } else {
          newCurrentStreak = 1;
          _logger.log(
            'Starting new streak',
            level: LogLevel.info,
          );
        }

        final newLongestStreak = newCurrentStreak > streak.longestStreak
            ? newCurrentStreak
            : streak.longestStreak;

        _logger.log(
          'Updating streak record',
          level: LogLevel.info,
          additionalData: {
            'currentStreak': newCurrentStreak,
            'longestStreak': newLongestStreak,
          },
        );

        await _streaksCollection.doc(userId).update({
          'currentStreak': newCurrentStreak,
          'longestStreak': newLongestStreak,
          'lastDreamDate': today.toIso8601String(),
          'hasLoggedDreamToday': true,
        });
      },
      operationName: 'updateStreak',
    );
  }

  Future<void> resetDailyFlag() async {
    await _networkRetry.retry(
      () async {
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
            _logger.log(
              'Resetting streak - missed a day',
              level: LogLevel.info,
              additionalData: {'userId': doc.id},
            );
            batch.update(doc.reference, {
              'currentStreak': 0,
              'hasLoggedDreamToday': false,
            });
          } else {
            batch.update(doc.reference, {'hasLoggedDreamToday': false});
          }
        }

        await batch.commit();
        _logger.log(
          'Daily flag reset completed',
          level: LogLevel.info,
          additionalData: {'processedUsers': snapshots.docs.length},
        );
      },
      operationName: 'resetDailyFlag',
    );
  }
}
