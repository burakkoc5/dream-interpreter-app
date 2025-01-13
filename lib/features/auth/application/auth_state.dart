import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/user_model.dart';

@immutable
class AuthState {
  final UserModel? user;
  final bool isInitializing;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isInitializing = false,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    UserModel? user,
    bool? isInitializing,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isInitializing: isInitializing ?? this.isInitializing,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
