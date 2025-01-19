import 'package:dream/core/routing/app_route_names.dart';
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

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _auth;
  final ProfileRepository _profileRepository;

  AuthCubit(this._authRepository, this._auth, this._profileRepository)
      : super(const AuthState(isInitializing: true)) {
    _auth.authStateChanges().listen((User? user) {
      debugPrint('AuthCubit - Auth state changed: ${user?.uid}');
      if (user != null) {
        final userModel = UserModel.fromFirebaseUser(user);
        debugPrint('AuthCubit - Created UserModel: ${userModel.id}');
        emit(AuthState(
          isInitializing: false,
          user: userModel,
        ));
      } else {
        debugPrint('AuthCubit - User is null, emitting unauthenticated state');
        emit(const AuthState(isInitializing: false));
      }
    });
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final user = await _authRepository.signIn(email, password);
      debugPrint('AuthCubit - Sign in successful: ${user.id}');

      if (!context.mounted) return;

      // Wait for Firebase Auth state to be updated
      int attempts = 0;
      while (_auth.currentUser == null && attempts < 3) {
        await Future.delayed(const Duration(milliseconds: 300));
        attempts++;
      }

      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        debugPrint('AuthCubit - User still null after waiting');
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: t.core.errors.userNotAuthenticated,
        );
      }

      emit(state.copyWith(
        user: UserModel(
          id: currentUser.uid,
          email: currentUser.email ?? email,
        ),
        isLoading: false,
      ));
      debugPrint('AuthCubit - Sign in successful: ${user.id}');

      if (!context.mounted) return;
      context.go(AppRoute.dreamEntry);
    } catch (e) {
      debugPrint('AuthCubit - Sign in error: $e');
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
      } else if (e is AuthError) {
        switch (e) {
          case AuthError.userNotFound:
            errorMessage = t.core.errors.userNotFound;
            break;
          case AuthError.wrongPassword:
            errorMessage = t.core.errors.wrongPassword;
            break;
          case AuthError.invalidEmail:
            errorMessage = t.core.errors.invalidEmail;
            break;
          default:
            errorMessage = t.core.errors.unknown;
        }
      }

      emit(state.copyWith(
        error: errorMessage,
        isLoading: false,
      ));
    }
  }

  Future<void> signOut() async {
    debugPrint('AuthCubit - Signing out');
    await _authRepository.signOut();
    emit(const AuthState());
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

      // Create initial profile and wait for it
      await _profileRepository.createInitialProfile(
        userId: userCredential.user!.uid,
        email: email,
      );

      // Load profile into ProfileCubit
      if (context.mounted) {
        final profileCubit = context.read<ProfileCubit>();
        profileCubit.loadProfile(userCredential.user!.uid);
      }

      final user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? email,
      );

      emit(state.copyWith(
        isLoading: false,
        user: user,
      ));

      if (context.mounted) {
        context.go(AppRoute.personalization);
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
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: t.core.errors.unknown,
      ));
    }
  }

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
}
