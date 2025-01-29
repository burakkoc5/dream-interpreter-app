import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:dream/core/network/network_retry.dart';
import 'package:dream/core/services/logging_service.dart';

@injectable
class StatsRepository {
  final FirebaseFirestore _firestore;
  final NetworkRetry _networkRetry;
  final LoggingService _logger;

  StatsRepository(
    this._firestore,
    LoggingService logger,
  )   : _logger = logger,
        _networkRetry = NetworkRetry(logger);

  Stream<Map<String, dynamic>> getUserStats(String userId) {
    _logger.log('Starting stats calculation',
        level: LogLevel.info, additionalData: {'userId': userId});
    return _networkRetry.retryWithFallback(
      () async {
        final userDreams = await _firestore
            .collection('dreams')
            .where('userId', isEqualTo: userId)
            .get();

        final now = DateTime.now();
        final weekStart = now
            .subtract(Duration(days: now.weekday - 1))
            .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

        int weeklyDreams = 0;
        List<DateTime> dreamDates = [];

        for (var dream in userDreams.docs) {
          final createdAt = dream.data()['createdAt'];
          DateTime dreamDate;
          if (createdAt is Timestamp) {
            dreamDate = createdAt.toDate();
          } else if (createdAt is String) {
            dreamDate = DateTime.parse(createdAt);
          } else {
            continue; // Skip if date is invalid
          }

          dreamDates.add(dreamDate);
          if (dreamDate.isAfter(weekStart)) {
            weeklyDreams++;
          }
        }

        // Sort dream dates from newest to oldest
        dreamDates.sort((a, b) => b.compareTo(a));

        // Calculate streaks
        int currentStreak = 0;
        int longestStreak = 0;
        int tempStreak = 0;
        DateTime? lastDate;

        if (dreamDates.isNotEmpty) {
          // Initialize with the first date
          lastDate = dreamDates[0];
          tempStreak = 1;
          currentStreak = 1;
          longestStreak = 1;

          // Check if the most recent dream is from today or yesterday
          final today = DateTime.now()
              .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
          final mostRecentDreamDate =
              lastDate.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
          final isActiveStreak =
              today.difference(mostRecentDreamDate).inDays <= 1;

          // If the streak is not active (no dream today or yesterday), reset current streak
          if (!isActiveStreak) {
            currentStreak = 0;
          }

          // Calculate streaks for the rest of the dates
          for (int i = 1; i < dreamDates.length; i++) {
            final currentDate = dreamDates[i];
            final difference = lastDate!.difference(currentDate).inDays;

            if (difference == 1) {
              // Consecutive day
              tempStreak++;
              if (tempStreak > longestStreak) {
                longestStreak = tempStreak;
              }
              if (isActiveStreak) {
                currentStreak = tempStreak;
              }
            } else if (difference > 1) {
              // Break in streak
              tempStreak = 1;
            }
            lastDate = currentDate;
          }
        }

        return {
          'totalDreams': userDreams.size,
          'weeklyDreams': weeklyDreams,
          'completionRate':
              userDreams.size > 0 ? weeklyDreams / userDreams.size : 0.0,
          'currentStreak': currentStreak,
          'longestStreak': longestStreak,
        };
      },
      {
        'totalDreams': 0,
        'weeklyDreams': 0,
        'completionRate': 0.0,
        'currentStreak': 0,
        'longestStreak': 0,
      },
      operationName: 'calculateUserStats',
    ).asStream();
  }
}
