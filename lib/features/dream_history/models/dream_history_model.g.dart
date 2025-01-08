// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DreamHistoryModelImpl _$$DreamHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DreamHistoryModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      interpretation: json['interpretation'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFavourite: json['isFavourite'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      moodRating: (json['moodRating'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DreamHistoryModelImplToJson(
        _$DreamHistoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'interpretation': instance.interpretation,
      'createdAt': instance.createdAt.toIso8601String(),
      'isFavourite': instance.isFavourite,
      'tags': instance.tags,
      'moodRating': instance.moodRating,
    };
