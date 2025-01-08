import 'package:freezed_annotation/freezed_annotation.dart';

part 'dream_history_model.freezed.dart';
part 'dream_history_model.g.dart';

@freezed
class DreamHistoryModel with _$DreamHistoryModel {
  const factory DreamHistoryModel({
    required String id,
    required String userId,
    required String title,
    required String content,
    required String interpretation,
    required DateTime createdAt,
    @Default(false) bool isFavourite,
    @Default([]) List<String> tags,
    @Default(0) int moodRating,
  }) = _DreamHistoryModel;

  factory DreamHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$DreamHistoryModelFromJson(json);
}
