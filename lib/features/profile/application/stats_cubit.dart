import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repositories/stats_repository.dart';
import 'stats_state.dart';

@injectable
class StatsCubit extends Cubit<StatsState> {
  final StatsRepository _repository;

  StatsCubit(this._repository) : super(const StatsState());

  Future<void> loadStats(String userId) async {
    emit(state.copyWith(isLoading: true));

    try {
      await for (final stats in _repository.getUserStats(userId)) {
        print(stats);
        emit(state.copyWith(
          isLoading: false,
          stats: stats,
          error: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load stats',
      ));
    }
  }
}
