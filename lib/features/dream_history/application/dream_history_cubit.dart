import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/dream_history_repository.dart';
import 'dream_history_state.dart';
import 'package:injectable/injectable.dart';

//TODO: Every user can see local history, but only if user ids match, they can see the history of other users. Fix this issue.
//TODO: On every refresh or load more, dreams are doubled. Fix this issue.
//TODO: Filters are not working properly. Fix this issue.
//TODO: Implement delete dream functionality. It gives firebase error. Fix this issue.
//TODO: Implement favorite dream button.
//TODO: Page transition animations.

@injectable
class DreamHistoryCubit extends Cubit<DreamHistoryState> {
  final DreamHistoryRepository _repository;
  final AuthCubit _authCubit;

  DreamHistoryCubit(this._repository, this._authCubit)
      : super(const DreamHistoryState());

  Future<void> loadDreams({bool refresh = false}) async {
    try {
      if (refresh) {
        emit(state.copyWith(
          isLoading: true,
          error: null,
          currentPage: 0,
          dreams: [],
          hasMore: true,
        ));
      } else {
        emit(state.copyWith(isLoading: true, error: null));
      }

      final userId = _authCubit.state.user?.id;
      if (userId == null) throw Exception('User not authenticated');

      final dreams = await _repository.getDreamHistory(
        userId,
        lastDocumentIndex: refresh ? null : state.currentPage * 10,
      );

      if (refresh) {
        emit(state.copyWith(
          dreams: dreams,
          isLoading: false,
          hasMore: dreams.length >= 10,
        ));
      } else {
        emit(state.copyWith(
          dreams: [...state.dreams, ...dreams],
          isLoading: false,
          hasMore: dreams.length >= 10,
        ));
      }
      _applyFilters();
    } catch (e) {
      emit(
          state.copyWith(error: 'Failed to load dreams: $e', isLoading: false));
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    try {
      emit(state.copyWith(isLoadingMore: true));

      final userId = _authCubit.state.user?.id;
      if (userId == null) throw Exception('User not authenticated');

      final nextPage = state.currentPage + 1;
      final moreDreams = await _repository.getDreamHistory(
        userId,
        lastDocumentIndex: nextPage * 10,
      );

      emit(state.copyWith(
        dreams: [...state.dreams, ...moreDreams],
        currentPage: nextPage,
        isLoadingMore: false,
        hasMore: moreDreams.length >= 10,
      ));
      _applyFilters();
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load more dreams: $e',
        isLoadingMore: false,
      ));
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
    _applyFilters();
  }

  void updateFilter(String filter) {
    emit(state.copyWith(selectedFilter: filter));
    _applyFilters();
  }

  Future<void> deleteDream(String dreamId) async {
    try {
      await _repository.deleteDream(dreamId);
      await loadDreams();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to delete dream: $e'));
    }
  }

  void _applyFilters() {
    List<DreamHistoryModel> filteredDreams = List.from(state.dreams);

    // Apply search filter
    if (state.searchQuery.isNotEmpty) {
      filteredDreams = filteredDreams
          .where((dream) =>
              dream.title
                  .toLowerCase()
                  .contains(state.searchQuery.toLowerCase()) ||
              dream.content
                  .toLowerCase()
                  .contains(state.searchQuery.toLowerCase()))
          .toList();
    }

    // Apply date/favorite filter
    switch (state.selectedFilter) {
      case 'This Week':
        final weekAgo = DateTime.now().subtract(const Duration(days: 7));
        filteredDreams = filteredDreams
            .where((dream) => dream.createdAt.isAfter(weekAgo))
            .toList();
        break;
      case 'This Month':
        final monthAgo = DateTime.now().subtract(const Duration(days: 30));
        filteredDreams = filteredDreams
            .where((dream) => dream.createdAt.isAfter(monthAgo))
            .toList();
        break;
    }

    emit(state.copyWith(filteredDreams: filteredDreams));
  }
}
