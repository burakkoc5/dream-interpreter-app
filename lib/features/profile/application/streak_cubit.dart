import 'dart:async';
import 'package:dream/features/profile/application/streak_state.dart';
import 'package:dream/features/profile/repositories/streak_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StreakCubit extends Cubit<StreakState> {
  final StreakRepository _repository;
  StreamSubscription? _streakSubscription;

  StreakCubit(this._repository) : super(const StreakState());

  Future<void> watchUserStreak(String userId) async {
    emit(state.copyWith(isLoading: true));
    await _streakSubscription?.cancel();
    _streakSubscription = _repository.watchUserStreak(userId).listen(
      (streak) => emit(state.copyWith(
        isLoading: false,
        streak: streak,
        error: null,
      )),
      onError: (error) {
        emit(state.copyWith(
          isLoading: false,
          streak: null,
          error: 'Failed to load streak',
        ));
      },
    );
  }

  Future<void> updateStreak(String userId) async {
    await _repository.updateStreak(userId);
  }

  void reset() {
    _streakSubscription?.cancel();
    _streakSubscription = null;
    emit(const StreakState());
  }

  @override
  Future<void> close() async {
    await _streakSubscription?.cancel();
    return super.close();
  }
}
