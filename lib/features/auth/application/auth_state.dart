import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/auth_error.dart';
import '../models/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    UserModel? user,
    @Default(false) bool isLoading,
    AuthError? error,
  }) = _AuthState;

  const AuthState._();

  bool get isAuthenticated => user != null;
}
