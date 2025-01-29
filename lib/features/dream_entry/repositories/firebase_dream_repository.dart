import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dream_entry_model.dart';
import 'dream_repository.dart';
import 'package:dream/core/network/network_retry.dart';
import 'package:dream/core/services/logging_service.dart';

/// Firebase implementation of DreamRepository
@Injectable(as: DreamRepository)
class FirebaseDreamRepository implements DreamRepository {
  final FirebaseFirestore _firestore;
  final NetworkRetry _networkRetry;
  final LoggingService _logger;

  FirebaseDreamRepository(
    this._firestore,
    LoggingService logger,
  )   : _logger = logger,
        _networkRetry = NetworkRetry(logger);

  @override
  Future<void> saveDream(DreamEntry dream) async {
    await _networkRetry.retry(
      () async {
        await _firestore.collection('dreams').doc(dream.id).set(dream.toJson());
        _logger.log(
          'Dream saved successfully',
          level: LogLevel.info,
          additionalData: {'dreamId': dream.id},
        );
      },
      operationName: 'saveDream',
    );
  }

  @override
  Future<void> updateDream(DreamEntry dream) async {
    await _networkRetry.retry(
      () async {
        await _firestore
            .collection('dreams')
            .doc(dream.id)
            .update(dream.toJson());
        _logger.log(
          'Dream updated successfully',
          level: LogLevel.info,
          additionalData: {'dreamId': dream.id},
        );
      },
      operationName: 'updateDream',
    );
  }

  @override
  Future<DreamEntry?> getDream(String id) async {
    return _networkRetry.retryWithFallback<DreamEntry?>(
      () async {
        final doc = await _firestore.collection('dreams').doc(id).get();
        if (!doc.exists) return null;
        return DreamEntry.fromJson(doc.data()!);
      },
      null,
      operationName: 'getDream',
    );
  }

  @override
  Future<List<DreamEntry>> getUserDreams(String userId) async {
    return _networkRetry.retryWithFallback<List<DreamEntry>>(
      () async {
        final snapshot = await _firestore
            .collection('dreams')
            .orderBy('createdAt', descending: true)
            .get();
        return snapshot.docs
            .map((doc) => DreamEntry.fromJson(doc.data()))
            .toList();
      },
      [],
      operationName: 'getUserDreams',
    );
  }

  @override
  Future<void> updateDreamTags(String dreamId, List<String> tags) async {
    await _networkRetry.retry(
      () async {
        await _firestore.collection('dreams').doc(dreamId).update({
          'tags': tags,
        });
        _logger.log(
          'Dream tags updated successfully',
          level: LogLevel.info,
          additionalData: {
            'dreamId': dreamId,
            'tagCount': tags.length,
          },
        );
      },
      operationName: 'updateDreamTags',
    );
  }

  @override
  Future<void> updateDreamMoodRating(String dreamId, int rating) async {
    await _networkRetry.retry(
      () async {
        await _firestore.collection('dreams').doc(dreamId).update({
          'moodRating': rating,
        });
        _logger.log(
          'Dream mood rating updated successfully',
          level: LogLevel.info,
          additionalData: {
            'dreamId': dreamId,
            'rating': rating,
          },
        );
      },
      operationName: 'updateDreamMoodRating',
    );
  }
}
