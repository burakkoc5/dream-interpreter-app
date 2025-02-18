import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    @Default(false) bool emailVerified,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirebaseUser(User user) => UserModel(
        id: user.uid,
        email: user.email!,
        emailVerified: user.emailVerified,
      );
}
