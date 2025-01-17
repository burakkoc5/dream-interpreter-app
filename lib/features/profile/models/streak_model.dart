import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_model.freezed.dart';
part 'streak_model.g.dart';

@freezed
class StreakModel with _$StreakModel {
  const factory StreakModel({
    required String userId,
    required int currentStreak,
    required int longestStreak,
    required DateTime lastDreamDate,
    @Default(false) bool hasLoggedDreamToday,
  }) = _StreakModel;

  factory StreakModel.fromJson(Map<String, dynamic> json) =>
      _$StreakModelFromJson(json);

  factory StreakModel.initial(String userId) => StreakModel(
        userId: userId,
        currentStreak: 0,
        longestStreak: 0,
        lastDreamDate: DateTime.now(),
        hasLoggedDreamToday: false,
      );
}
