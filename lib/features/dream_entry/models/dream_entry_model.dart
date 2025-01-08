import 'package:freezed_annotation/freezed_annotation.dart';

part 'dream_entry_model.freezed.dart';
part 'dream_entry_model.g.dart';

/// Model representing a dream entry with its interpretation
@freezed
class DreamEntry with _$DreamEntry {
  const factory DreamEntry({
    required String id,
    required String userId,
    required String title,
    required String content,
    required String interpretation,
    required DateTime createdAt,
    @Default(false) bool isFavourite,
    @Default([]) List<String> tags,
    @Default(0) int moodRating,
  }) = _DreamEntry;

  factory DreamEntry.fromJson(Map<String, dynamic> json) =>
      _$DreamEntryFromJson(json);
}
