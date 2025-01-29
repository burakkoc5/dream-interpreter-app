import 'package:injectable/injectable.dart';
import '../models/user_model.dart';
import '../services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show UserCredential, EmailAuthProvider;
import 'package:dream/core/network/network_retry.dart';
import 'package:dream/core/services/logging_service.dart';

/// Repository handling authentication operations.
@injectable
class AuthRepository {
  final FirebaseAuthService _authService;
  final NetworkRetry _networkRetry;
  final LoggingService _logger;

  AuthRepository(
    this._authService,
    LoggingService logger,
  )   : _logger = logger,
        _networkRetry = NetworkRetry(logger);

  /// Signs in a user with email and password.
  Future<UserModel> signIn(String email, String password) =>
      _networkRetry.retry(
        () => _authService.signInWithEmailAndPassword(email, password),
        operationName: 'signIn',
      );

  /// Registers a new user with email and password.
  Future<UserModel> register(String email, String password) async {
    return _networkRetry.retry(
      () async {
        final userCredential =
            await _authService.createUserWithEmailAndPassword(
          email,
          password,
        );
        _logger.log(
          'User registered successfully',
          level: LogLevel.info,
          additionalData: {'email': email},
        );
        return UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          emailVerified: userCredential.user!.emailVerified,
        );
      },
      operationName: 'register',
    );
  }

  /// Sends a password reset email.
  Future<void> resetPassword(String email) => _networkRetry.retry(
        () => _authService.sendPasswordResetEmail(email),
        operationName: 'resetPassword',
      );

  /// Signs out the current user.
  Future<void> signOut() => _networkRetry.retry(
        () => _authService.signOut(),
        operationName: 'signOut',
      );

  /// Stream of authentication state changes.
  Stream<UserModel?> get authStateChanges => _authService.authStateChanges;

  /// Signs up a new user with email and password (returns UserCredential).
  Future<UserCredential> signUp(String email, String password) {
    _logger.log(
      'Starting user signup',
      level: LogLevel.info,
      additionalData: {'email': email},
    );
    return _networkRetry.retry(
      () => _authService.createUserWithEmailAndPassword(email, password),
      operationName: 'signUp',
    );
  }

  /// Get the authentication status.
  bool get isAuthenticated => _authService.isAuthenticated;

  /// Check if the current user's email is verified
  bool get isEmailVerified => _authService.currentUser?.emailVerified ?? false;

  /// Send email verification to current user
  Future<void> sendEmailVerification() => _networkRetry.retry(
        () => _authService.sendEmailVerification(),
        operationName: 'sendEmailVerification',
      );

  /// Reload the current user to get the latest verification status
  Future<void> reloadUser() => _networkRetry.retry(
        () => _authService.reloadUser(),
        operationName: 'reloadUser',
      );

  /// Update user's email verification status in Firestore
  Future<void> updateEmailVerificationStatus() => _networkRetry.retry(
        () => _authService.updateEmailVerificationStatus(),
        operationName: 'updateEmailVerificationStatus',
      );

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _networkRetry.retry(
      () async {
        final user = _authService.currentUser;
        if (user == null) throw Exception('No user is currently signed in');

        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        _logger.log(
          'Password changed successfully',
          level: LogLevel.info,
        );
      },
      operationName: 'changePassword',
    );
  }

  Future<void> deleteAccount() => _networkRetry.retry(
        () => _authService.deleteAccount(),
        operationName: 'deleteAccount',
      );
}
