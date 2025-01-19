import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String userId,
    required String email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool notificationsEnabled,
    @Default({}) Map<String, dynamic> preferences,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime lastActive,
    // Personal Information
    String? gender,
    String? horoscope,
    String? occupation,
    String? relationshipStatus,
    DateTime? birthDate,
    @Default([]) List<String> interests,
    @Default(false) bool hasCompletedPersonalization,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
