import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/models/auth_error.dart';
import 'package:dream/features/auth/models/user_model.dart';
import 'package:dream/features/auth/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _auth;

  AuthCubit(this._authRepository, this._auth)
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
      emit(state.copyWith(user: user, isLoading: false));
      context.go(AppRoute.dreamEntry);
    } catch (e) {
      debugPrint('AuthCubit - Sign in error: $e');
      emit(state.copyWith(
        error: e is AuthError ? e.toString() : 'Unknown error occurred',
        isLoading: false,
      ));
    }
  }

  Future<void> signOut() async {
    debugPrint('AuthCubit - Signing out');
    await _authRepository.signOut();
    emit(const AuthState());
  }

  Future<void> register(
      String email, String password, BuildContext context) async {
    emit(state.copyWith(isLoading: true, error: null));
    debugPrint('AuthCubit - Registering user with email: $email');
    try {
      final user = await _authRepository.register(email, password);
      debugPrint('AuthCubit - User registered: ${user.id}');
      emit(state.copyWith(user: user, isLoading: false));
      if (context.mounted) {
        context.go(AppRoute.dreamEntry);
      }
    } catch (e) {
      debugPrint('AuthCubit - Registration error: $e');
      emit(state.copyWith(
        error: e is AuthError ? e.toString() : 'Unknown error occurred',
        isLoading: false,
      ));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await _authRepository.resetPassword(email);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: e is AuthError ? e.toString() : 'Unknown error occurred',
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
