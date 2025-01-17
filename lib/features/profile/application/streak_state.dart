import 'package:dream/features/profile/models/streak_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_state.freezed.dart';

@freezed
class StreakState with _$StreakState {
  const factory StreakState({
    @Default(true) bool isLoading,
    StreakModel? streak,
  }) = _StreakState;
}
