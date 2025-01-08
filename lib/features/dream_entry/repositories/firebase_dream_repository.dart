import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dream_entry_model.dart';
import 'dream_repository.dart';

/// Firebase implementation of DreamRepository
@Injectable(as: DreamRepository)
class FirebaseDreamRepository implements DreamRepository {
  final FirebaseFirestore _firestore;

  FirebaseDreamRepository(this._firestore);

  @override
  Future<void> saveDream(DreamEntry dream) async {
    await _firestore.collection('dreams').doc(dream.id).set(dream.toJson());
  }

  @override
  Future<void> updateDream(DreamEntry dream) async {
    await _firestore.collection('dreams').doc(dream.id).update(dream.toJson());
  }

  @override
  Future<DreamEntry?> getDream(String id) async {
    final doc = await _firestore.collection('dreams').doc(id).get();
    if (!doc.exists) return null;
    return DreamEntry.fromJson(doc.data()!);
  }

  @override
  Future<List<DreamEntry>> getUserDreams(String userId) async {
    final snapshot = await _firestore
        .collection('dreams')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => DreamEntry.fromJson(doc.data())).toList();
  }

  @override
  Future<void> updateDreamTags(String dreamId, List<String> tags) async {
    await _firestore.collection('dreams').doc(dreamId).update({
      'tags': tags,
    });
  }

  @override
  Future<void> updateDreamMoodRating(String dreamId, int rating) async {
    await _firestore.collection('dreams').doc(dreamId).update({
      'moodRating': rating,
    });
  }
}
