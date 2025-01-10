import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/core/di/injection.dart';
import 'package:injectable/injectable.dart';
import '../models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Repository handling profile-related data operations
@injectable
class ProfileRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = getIt<FirebaseAuth>();

  ProfileRepository(this._firestore);

  Stream<Profile> getProfile(String userId) {
    print('ProfileRepository: Getting profile for user $userId');
    (_firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .length
        .then((value) => print('ProfileRepository: Profile length: $value')));
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => Profile.fromJson(doc.data()!));
  }

  Future<void> updateProfile(Profile profile) async {
    await _firestore
        .collection('users')
        .doc(profile.userId)
        .update(profile.toJson());
  }

  Future<void> updateProfilePreferences(Map<String, dynamic> data) async {
    print('ProfileRepository: Updating profile preferences');
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    await _firestore.collection('users').doc(userId).update(data);
  }

  Future<void> createInitialProfile({
    required String userId,
    required String email,
  }) async {
    try {
      print('ProfileRepository: Starting profile creation for user $userId');

      final now = FieldValue.serverTimestamp();
      await _firestore.collection('users').doc(userId).set({
        'userId': userId,
        'email': email,
        'displayName': null,
        'photoUrl': null, // We'll update this when user selects a photo
        'createdAt': now,
        'lastActive': now,
        'notificationsEnabled': false,
        'preferences': {},
      });

      print('ProfileRepository: Profile created successfully for user $userId');
    } catch (e) {
      print('ProfileRepository: Error creating profile: $e');
      rethrow;
    }
  }

  Future<void> updateProfilePhoto(String userId, String photoUrl) {
    return _firestore.collection('users').doc(userId).update({
      'photoUrl': photoUrl,
      'lastActive': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateDisplayName(String newName) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _firestore
        .collection('users')
        .doc(user.uid)
        .update({'displayName': newName});
    print('ProfileRepository: Display name updated successfully');
  }
}
