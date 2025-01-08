import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

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
    return _firestore
        .collection('dreams')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      print('Number of documents: ${snapshot.docs.length}');
      if (snapshot.docs.isEmpty) {
        return {
          'totalDreams': 0,
          'weeklyDreams': 0,
          'completionRate': 0.0,
        };
      }

      final dreams = snapshot.docs;
      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));

      try {
        int totalDreams = dreams.length;
        int weeklyDreams = dreams.where((doc) {
          final createdAt = doc.data()['createdAt'];
          final dreamDate = _parseDate(createdAt);
          return dreamDate != null && dreamDate.isAfter(weekAgo);
        }).length;

        int dreamsWithInterpretation = dreams.where((doc) {
          final interpretation = doc.data()['interpretation'];
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

        return {
          'totalDreams': totalDreams,
          'weeklyDreams': weeklyDreams,
          'completionRate': completionRate,
        };
      } catch (e) {
        print('Error calculating stats: $e');
        return {
          'totalDreams': 0,
          'weeklyDreams': 0,
          'completionRate': 0.0,
          'error': e.toString(),
        };
      }
    });
  }
}
