import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String userId,
    required String email,
    String? displayName,
    String? photoUrl,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime lastActive,
    required bool notificationsEnabled,
    required Map<String, dynamic> preferences,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

/// Converter for Firestore Timestamp
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
