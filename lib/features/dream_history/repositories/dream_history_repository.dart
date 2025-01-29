import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dream/features/dream_entry/services/local_storage_service.dart';
import 'package:dream/core/network/network_retry.dart';
import 'package:dream/core/services/logging_service.dart';

@injectable
class DreamHistoryRepository {
  final FirebaseFirestore _firestore;
  final LocalStorageService _localStorageService;
  final NetworkRetry _networkRetry;

  DreamHistoryRepository(
    this._firestore,
    this._localStorageService,
    LoggingService loggingService,
  ) : _networkRetry = NetworkRetry(loggingService);

  static const int pageSize = 10;

  Future<Map<String, dynamic>> getDreamHistory(
    String userId, {
    DocumentSnapshot? lastDocument,
  }) async {
    return _networkRetry.retry(
      () async {
        var query = _firestore
            .collection('dreams')
            .where('userId', isEqualTo: userId)
            .orderBy('createdAt', descending: true)
            .limit(pageSize);

        if (lastDocument != null) {
          query = query.startAfterDocument(lastDocument);
        }

        final snapshot = await query.get();

        if (snapshot.docs.isEmpty) {
          return {
            'dreams': [],
            'lastDocument': lastDocument,
            'isNewData': false,
          };
        }

        final dreams = snapshot.docs.map((doc) {
          final data = doc.data();

          DateTime createdAt;
          final createdAtData = data['createdAt'];
          if (createdAtData is Timestamp) {
            createdAt = createdAtData.toDate();
          } else if (createdAtData is String) {
            createdAt = DateTime.parse(createdAtData);
          } else {
            createdAt = DateTime.now();
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

        return {
          'dreams': dreams,
          'lastDocument': snapshot.docs.last,
          'isNewData': true,
        };
      },
      operationName: 'getDreamHistory',
    );
  }

  Future<void> deleteDream(String dreamId) async {
    await _networkRetry.retry(
      () async {
        final docSnapshot =
            await _firestore.collection('dreams').doc(dreamId).get();

        if (!docSnapshot.exists) {
          throw Exception('Dream not found');
        }

        final data = docSnapshot.data();
        if (data == null) {
          throw Exception('Dream data is null');
        }

        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          throw Exception('No user is currently signed in');
        }

        if (data['userId'] != currentUser.uid) {
          throw Exception('You do not have permission to delete this dream');
        }

        final draft = await _localStorageService.getDraft();
        if (draft != null && draft.id == dreamId) {
          await _localStorageService.clearDraft();
        }

        await _firestore.collection('dreams').doc(dreamId).delete();
      },
      operationName: 'deleteDream',
    );
  }

  Future<void> updateDream(DreamHistoryModel dream) async {
    await _networkRetry.retry(
      () async {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          throw Exception('No user is currently signed in');
        }

        if (dream.userId != currentUser.uid) {
          throw Exception('You do not have permission to update this dream');
        }

        await _firestore
            .collection('dreams')
            .doc(dream.id)
            .update(dream.toJson());
      },
      operationName: 'updateDream',
    );
  }

  Future<List<String>> getAllTags(String userId) async {
    return _networkRetry.retryWithFallback(
      () async {
        final snapshot = await _firestore
            .collection('dreams')
            .where('userId', isEqualTo: userId)
            .get();

        final Set<String> allTags = {};
        for (final doc in snapshot.docs) {
          final data = doc.data();
          final tags = (data['tags'] as List<dynamic>?)?.cast<String>() ?? [];
          allTags.addAll(tags);
        }

        return allTags.toList()..sort();
      },
      [],
      operationName: 'getAllTags',
    );
  }
}
