import 'package:injectable/injectable.dart';
import '../models/user_model.dart';
import '../services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:firebase_auth/firebase_auth.dart' show EmailAuthProvider;

/// Repository handling authentication operations.
@injectable
class AuthRepository {
  final FirebaseAuthService _authService;

  AuthRepository(this._authService);

  /// Signs in a user with email and password.
  Future<UserModel> signIn(String email, String password) =>
      _authService.signInWithEmailAndPassword(email, password);

  /// Registers a new user with email and password.
  Future<UserModel> register(String email, String password) async {
    final userCredential = await _authService.createUserWithEmailAndPassword(
      email,
      password,
    );
    return UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
    );
  }

  /// Sends a password reset email.
  Future<void> resetPassword(String email) =>
      _authService.sendPasswordResetEmail(email);

  /// Signs out the current user.
  Future<void> signOut() => _authService.signOut();

  /// Stream of authentication state changes.
  Stream<UserModel?> get authStateChanges => _authService.authStateChanges;

  /// Signs up a new user with email and password (returns UserCredential).
  Future<UserCredential> signUp(String email, String password) {
    print('Signing up user with email: $email');
    return _authService.createUserWithEmailAndPassword(email, password);
  }

  /// Get the authentication status.
  bool get isAuthenticated => _authService.isAuthenticated;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _authService.currentUser;
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }
}
