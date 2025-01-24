import 'package:dream/features/profile/models/streak_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class StreakState {
  final bool isLoading;
  final StreakModel? streak;
  final String? error;

  const StreakState({
    this.isLoading = false,
    this.streak,
    this.error,
  });

  StreakState copyWith({
    bool? isLoading,
    StreakModel? streak,
    String? error,
  }) {
    return StreakState(
      isLoading: isLoading ?? this.isLoading,
      streak: streak ?? this.streak,
      error: error ?? this.error,
    );
  }
}
