import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/models/auth_error.dart';
import 'package:dream/features/auth/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState()) {
    _init();
  }

  void _init() {
    _authRepository.authStateChanges.listen((user) {
      emit(state.copyWith(user: user));
    });
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final user = await _authRepository.signIn(email, password);
      emit(state.copyWith(user: user, isLoading: false));
      context.go(AppRoute.dreamEntry);
    } catch (e) {
      emit(state.copyWith(
        error: e is AuthError ? e : AuthError.unknown,
        isLoading: false,
      ));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(const AuthState());
  }

  Future<void> register(
      String email, String password, BuildContext context) async {
    emit(state.copyWith(isLoading: true, error: null));
    print('Registering user with email: $email');
    try {
      final user = await _authRepository.register(email, password);
      print('User registered: ${user.email}');
      emit(state.copyWith(user: user, isLoading: false));
      await Future.delayed(Duration(milliseconds: 100));
      print(state.isAuthenticated);
      if (context.mounted) {
        GoRouter.of(context).go(AppRoute.dreamEntry);
      }
    } catch (e) {
      emit(state.copyWith(
        error: e is AuthError ? e : AuthError.unknown,
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
        error: e is AuthError ? e : AuthError.unknown,
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
        error: e is AuthError ? e : AuthError.unknown,
        isLoading: false,
      ));
    }
  }
}
