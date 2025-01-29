import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repositories/stats_repository.dart';
import 'stats_state.dart';

@injectable
class StatsCubit extends Cubit<StatsState> {
  final StatsRepository _repository;
  StreamSubscription? _statsSubscription;

  StatsCubit(this._repository) : super(const StatsState());

  Future<void> loadStats(String userId) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _statsSubscription?.cancel();
      _statsSubscription = _repository.getUserStats(userId).listen(
        (stats) {
          emit(state.copyWith(
            isLoading: false,
            stats: stats,
            error: null,
          ));
        },
        onError: (error) {
          emit(state.copyWith(
            isLoading: false,
            error: 'Failed to load stats',
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load stats',
      ));
    }
  }

  void reset() {
    _statsSubscription?.cancel();
    _statsSubscription = null;
    emit(const StatsState());
  }

  @override
  Future<void> close() async {
    await _statsSubscription?.cancel();
    return super.close();
  }
}
