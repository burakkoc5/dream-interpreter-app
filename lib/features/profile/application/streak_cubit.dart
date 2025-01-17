import 'dart:async';
import 'package:dream/features/profile/application/streak_state.dart';
import 'package:dream/features/profile/repository/streak_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreakCubit extends Cubit<StreakState> {
  final StreakRepository _repository;
  StreamSubscription? _streakSubscription;

  StreakCubit({
    required StreakRepository repository,
  })  : _repository = repository,
        super(const StreakState());

  Future<void> watchUserStreak(String userId) async {
    emit(state.copyWith(isLoading: true));
    await _streakSubscription?.cancel();
    _streakSubscription = _repository.watchUserStreak(userId).listen(
          (streak) => emit(state.copyWith(
            isLoading: false,
            streak: streak,
          )),
        );
  }

  Future<void> updateStreak(String userId) async {
    await _repository.updateStreak(userId);
  }

  @override
  Future<void> close() async {
    await _streakSubscription?.cancel();
    return super.close();
  }
}
