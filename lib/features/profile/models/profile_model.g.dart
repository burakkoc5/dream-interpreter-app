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
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      lastActive:
          const TimestampConverter().fromJson(json['lastActive'] as Timestamp),
      notificationsEnabled: json['notificationsEnabled'] as bool,
      preferences: json['preferences'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'lastActive': const TimestampConverter().toJson(instance.lastActive),
      'notificationsEnabled': instance.notificationsEnabled,
      'preferences': instance.preferences,
    };
