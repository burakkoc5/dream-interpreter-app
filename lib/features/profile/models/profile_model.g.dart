// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      userId: json['userId'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? false,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      lastActive:
          const TimestampConverter().fromJson(json['lastActive'] as Timestamp),
      gender: json['gender'] as String?,
      horoscope: json['horoscope'] as String?,
      occupation: json['occupation'] as String?,
      relationshipStatus: json['relationshipStatus'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hasCompletedPersonalization:
          json['hasCompletedPersonalization'] as bool? ?? false,
      remainingDailyAttempts:
          (json['remainingDailyAttempts'] as num?)?.toInt() ?? 2,
      lastAttemptsResetDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastAttemptsResetDate'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'notificationsEnabled': instance.notificationsEnabled,
      'preferences': instance.preferences,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'lastActive': const TimestampConverter().toJson(instance.lastActive),
      'gender': instance.gender,
      'horoscope': instance.horoscope,
      'occupation': instance.occupation,
      'relationshipStatus': instance.relationshipStatus,
      'birthDate': instance.birthDate?.toIso8601String(),
      'interests': instance.interests,
      'hasCompletedPersonalization': instance.hasCompletedPersonalization,
      'remainingDailyAttempts': instance.remainingDailyAttempts,
      'lastAttemptsResetDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastAttemptsResetDate, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
