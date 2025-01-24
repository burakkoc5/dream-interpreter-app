import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/core/di/injection.dart';
import 'package:flutter/material.dart';
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
    debugPrint('ProfileRepository: Getting profile for user $userId');
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .handleError((error, stackTrace) {
      debugPrint('ProfileRepository: Error getting profile: $error');
      if (error is FirebaseException && error.code == 'permission-denied') {
        throw Exception('User not authenticated or email not verified');
      }
      throw error;
    }).map((doc) {
      if (!doc.exists) {
        throw Exception('Profile not found');
      }
      try {
        return Profile.fromJson(doc.data()!);
      } catch (e) {
        debugPrint('ProfileRepository: Error parsing profile: $e');
        rethrow;
      }
    });
  }

  Future<void> updateProfile(Profile profile) async {
    debugPrint('ProfileRepository: Updating profile: ${profile.toJson()}');
    await _firestore
        .collection('users')
        .doc(profile.userId)
        .set(profile.toJson(), SetOptions(merge: true));
  }

  Future<void> updateProfilePreferences(Map<String, dynamic> data) async {
    debugPrint('ProfileRepository: Updating profile preferences');
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    await _firestore.collection('users').doc(userId).update(data);
  }

  Future<void> createInitialProfile({
    required String userId,
    required String email,
  }) async {
    try {
      debugPrint(
          'ProfileRepository: Starting profile creation for user $userId');

      final now = DateTime.now();
      final data = {
        'userId': userId,
        'email': email,
        'displayName': email.split('@').first, // Set a default display name
        'photoUrl': null,
        'createdAt': Timestamp.fromDate(now),
        'lastActive': Timestamp.fromDate(now),
        'notificationsEnabled': false,
        'preferences': {},
        'gender': null,
        'horoscope': null,
        'occupation': null,
        'relationshipStatus': null,
        'birthDate': null,
        'interests': <String>[],
        'hasCompletedPersonalization': false,
        'remainingDailyAttempts': 2,
        'lastAttemptsResetDate': Timestamp.fromDate(now),
      };

      // Use set with merge to avoid overwriting if document already exists
      await _firestore
          .collection('users')
          .doc(userId)
          .set(data, SetOptions(merge: true));

      debugPrint(
          'ProfileRepository: Profile created successfully for user $userId');
    } catch (e) {
      debugPrint('ProfileRepository: Error creating profile: $e');
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
    debugPrint('ProfileRepository: Display name updated successfully');
  }
}
