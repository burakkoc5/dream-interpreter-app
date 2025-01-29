import 'package:dream/features/auth/models/auth_error.dart';
import 'package:dream/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service handling Firebase authentication operations.
@injectable
class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseAuthService(this._firebaseAuth, this._firestore);

  /// Get the authentication status
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  /// Signs in a user with email and password.
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: t.core.errors.userNotFound,
        );
      }

      // Wait for the user to be fully loaded first
      await userCredential.user!.reload();
      final currentUser = _firebaseAuth.currentUser;

      if (currentUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: t.core.errors.userNotAuthenticated,
        );
      }

      // Create or update user document in Firestore
      try {
        await _firestore.collection('users').doc(currentUser.uid).set({
          'email': email,
          'lastLogin': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } catch (e) {
        // Don't fail the sign-in if Firestore update fails
      }

      return UserModel(
        id: currentUser.uid,
        email: currentUser.email ?? email,
        emailVerified: currentUser.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw AuthError.unknown;
    }
  }

  /// Creates a new user account with email and password.
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      final now = DateTime.now();
      // Get the username part from email (everything before @)
      final defaultDisplayName = email.split('@').first;

      // Create user document in Firestore using Profile model
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'userId': userCredential.user!.uid,
        'email': email,
        'displayName': defaultDisplayName,
        'photoUrl': 'assets/avatars/avatar1.svg',
        'createdAt': Timestamp.fromDate(now),
        'lastActive': Timestamp.fromDate(now),
        'notificationsEnabled': true,
        'preferences': {},
        'emailVerified': false,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    }
  }

  /// Sends a password reset email to the specified email address.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    }
  }

  /// Signs out the current user.
  Future<void> signOut() => _firebaseAuth.signOut();

  /// Stream of authentication state changes.
  Stream<UserModel?> get authStateChanges => _firebaseAuth
      .authStateChanges()
      .map((user) => user != null ? UserModel.fromFirebaseUser(user) : null);

  /// Handles Firebase authentication errors and converts them to [AuthError].
  AuthError _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthError.userNotFound;
      case 'wrong-password':
        return AuthError.wrongPassword;
      case 'email-already-in-use':
        return AuthError.emailAlreadyInUse;
      case 'invalid-email':
        return AuthError.invalidEmail;
      case 'weak-password':
        return AuthError.weakPassword;
      default:
        return AuthError.unknown;
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Check if the current user's email is verified
  bool get isEmailVerified => _firebaseAuth.currentUser?.emailVerified ?? false;

  /// Send email verification to current user
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  /// Reload the current user to get the latest email verification status
  Future<void> reloadUser() async {
    await _firebaseAuth.currentUser?.reload();
  }

  /// Update user's email verification status in Firestore
  Future<void> updateEmailVerificationStatus() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'emailVerified': user.emailVerified,
      });
    }
  }

  Future<void> deleteAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw Exception('No user signed in');

    final userId = user.uid;
    final batch = _firestore.batch();

    // Delete user profile
    batch.delete(_firestore.collection('users').doc(userId));

    // Delete user's dreams
    final dreams = await _firestore
        .collection('dreams')
        .where('userId', isEqualTo: userId)
        .get();
    for (var dream in dreams.docs) {
      batch.delete(dream.reference);
    }

    // Delete user's streak data
    batch.delete(_firestore.collection('streaks').doc(userId));

    // Delete user's stats
    batch.delete(_firestore.collection('stats').doc(userId));

    // Execute batch delete
    await batch.commit();

    // Delete Firebase Auth account
    await user.delete();
  }
}
