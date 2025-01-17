import 'package:cloud_firestore/cloud_firestore.dart';
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
    print('Fetching stats for userId: $userId');

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
        print('Number of documents: ${dreamsSnapshot.docs.length}');

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

          print('Stats calculated successfully:');
          print('Total dreams: $totalDreams');
          print('Weekly dreams: $weeklyDreams');
          print('Completion rate: $completionRate');
          print('Current streak: $currentStreak');
          print('Longest streak: $longestStreak');

          return {
            'totalDreams': totalDreams,
            'weeklyDreams': weeklyDreams,
            'completionRate': completionRate,
            'currentStreak': currentStreak,
            'longestStreak': longestStreak,
          };
        } catch (e) {
          print('Error calculating stats: $e');
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
