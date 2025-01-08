import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_state.freezed.dart';

@freezed
class StatsState with _$StatsState {
  const factory StatsState({
    @Default(false) bool isLoading,
    @Default({}) Map<String, dynamic> stats,
    String? error,
  }) = _StatsState;
}
