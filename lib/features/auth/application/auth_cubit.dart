import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/core/services/logging_service.dart';
import 'package:dream/features/auth/models/auth_error.dart';
import 'package:dream/features/auth/models/user_model.dart';
import 'package:dream/features/auth/repositories/auth_repository.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dream/features/profile/repositories/profile_repository.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/profile/application/stats_cubit.dart';
import 'package:dream/features/profile/application/streak_cubit.dart';
import 'package:dream/features/auth/presentation/widgets/email_verification_dialog.dart';
import 'package:dream/shared/widgets/app_toast.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _auth;
  final ProfileRepository _profileRepository;
  final LoggingService _loggingService;

  AuthCubit(
    this._authRepository,
    this._auth,
    this._profileRepository,
    LoggingService loggingService,
  )   : _loggingService = loggingService,
        super(const AuthState(isInitializing: true)) {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        final userModel = UserModel.fromFirebaseUser(user);
        emit(AuthState(
          isInitializing: false,
          user: userModel,
        ));
      } else {
        emit(const AuthState(isInitializing: false));
      }
    });
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final user = await _authRepository.signIn(email, password);

      if (!context.mounted) return;

      // Wait for Firebase Auth state to be updated
      int attempts = 0;
      while (_auth.currentUser == null && attempts < 3) {
        await Future.delayed(const Duration(milliseconds: 300));
        attempts++;
      }

      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: t.core.errors.userNotAuthenticated,
        );
      }

      // Check email verification
      await currentUser.reload();
      if (!currentUser.emailVerified) {
        emit(state.copyWith(isLoading: false));
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => EmailVerificationDialog(
              email: email,
              isSignIn: true,
              onResendEmail: () async {
                await currentUser.sendEmailVerification();
                if (context.mounted) {
                  Navigator.of(context).pop();
                  showSuccessSnackBar(
                    context,
                    'Verification email sent',
                  );
                }
              },
            ),
          );
        }
        return;
      }

      emit(state.copyWith(
        user: UserModel(
          id: user.id,
          email: user.email,
          emailVerified: user.emailVerified,
        ),
        isLoading: false,
      ));

      if (!context.mounted) return;

      // Check if personalization is completed
      final profile = await _profileRepository.getProfile(user.id).first;
      if (!profile.hasCompletedPersonalization) {
        if (!context.mounted) return;

        context.go(AppRoute.personalization);
      } else {
        if (!context.mounted) return;

        context.go(AppRoute.dreamEntry);
      }
    } catch (e) {
      String errorMessage = t.core.errors.unknown;

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = t.core.errors.userNotFound;
            break;
          case 'wrong-password':
            errorMessage = t.core.errors.wrongPassword;
            break;
          case 'invalid-email':
            errorMessage = t.core.errors.invalidEmail;
            break;
          case 'user-disabled':
            errorMessage = t.core.errors.userNotAuthenticated;
            break;
          default:
            errorMessage = e.message ?? t.core.errors.unknown;
        }
      }

      emit(state.copyWith(
        error: errorMessage,
        isLoading: false,
      ));
      if (context.mounted) {
        showErrorSnackBar(context, errorMessage);
      }
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send verification email
      await userCredential.user?.sendEmailVerification();

      // Create initial profile and wait for it
      await _profileRepository.createInitialProfile(
        userId: userCredential.user!.uid,
        email: email,
      );

      // Sign out immediately after registration to force login after verification
      await _auth.signOut();

      emit(state.copyWith(
        isLoading: false,
        user: null,
      ));

      if (context.mounted) {
        // Show email verification dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => EmailVerificationDialog(
            email: email,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = t.core.errors.emailAlreadyInUse;
          break;
        case 'invalid-email':
          errorMessage = t.core.errors.invalidEmail;
          break;
        case 'operation-not-allowed':
          errorMessage = t.core.errors.unknown;
          break;
        case 'weak-password':
          errorMessage = t.core.errors.weakPassword;
          break;
        default:
          errorMessage = t.core.errors.unknown;
      }
      emit(state.copyWith(
        isLoading: false,
        error: errorMessage,
      ));
      if (context.mounted) {
        showErrorSnackBar(context, errorMessage);
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: t.core.errors.unknown,
      ));
      if (context.mounted) {
        showErrorSnackBar(context, t.core.errors.unknown);
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      // First emit unauthenticated state to prevent any subscriptions from trying to access data
      emit(const AuthState(isInitializing: false));

      // Then perform the actual sign out
      await _authRepository.signOut();

      // Only after sign out is complete, reset all states
      if (context.mounted) {
        try {
          // Reset profile first since other cubits might depend on it
          context.read<ProfileCubit>().reset();

          // Reset other cubits
          context.read<DreamEntryCubit>().reset();
          context.read<DreamHistoryCubit>().reset();

          try {
            context.read<StatsCubit>().reset();
          } catch (e) {
            _loggingService.log('Error resetting StatsCubit',
                level: LogLevel.error, error: e);
          }

          try {
            context.read<StreakCubit>().reset();
          } catch (e) {
            _loggingService.log('Error resetting StreakCubit',
                level: LogLevel.error, error: e);
          }
        } catch (e) {
          _loggingService.log('Error resetting cubits',
              level: LogLevel.error, error: e);
          // Don't rethrow as we want to continue with navigation
        }
      }

      // Finally navigate to login
      if (context.mounted) {
        context.go(AppRoute.login);
      }
    } catch (e) {
      // Even if there's an error, try to navigate to login
      if (context.mounted) {
        context.go(AppRoute.login);
      }
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _authRepository.deleteAccount();
      if (!context.mounted) return;
      context.go(AppRoute.login);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
      if (context.mounted) {
        showErrorSnackBar(context, e.toString());
      }
    }
  }

  /// Check email verification status and update if necessary
  Future<void> checkEmailVerification() async {
    if (state.user != null) {
      await _authRepository.reloadUser();
      if (_authRepository.isEmailVerified) {
        await _authRepository.updateEmailVerificationStatus();
      }
    }
  }

  /// Resend verification email
  Future<void> resendVerificationEmail(BuildContext context) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        if (context.mounted) {
          showSuccessSnackBar(
            context,
            'Verification email sent',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showErrorSnackBar(context, e.toString());
      }
    }
  }

  /// Get email verification status
  bool get isEmailVerified => _authRepository.isEmailVerified;

  Future<void> resetPassword(String email) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await _authRepository.resetPassword(email);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      String errorMessage;
      if (e is AuthError) {
        switch (e) {
          case AuthError.userNotFound:
            errorMessage = t.core.errors.userNotFound;
            break;
          case AuthError.invalidEmail:
            errorMessage = t.core.errors.invalidEmail;
            break;
          default:
            errorMessage = t.core.errors.unknown;
        }
      } else {
        errorMessage = t.core.errors.unknown;
      }
      emit(state.copyWith(
        error: errorMessage,
        isLoading: false,
      ));
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await _authRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: e is AuthError ? e.toString() : 'Unknown error occurred',
        isLoading: false,
      ));
    }
  }

  void showErrorSnackBar(BuildContext context, String message) {
    AppToast.showError(
      context,
      title: t.core.errors.error,
      description: message,
    );
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    AppToast.showSuccess(
      context,
      title: t.core.success,
      description: message,
    );
  }
}
