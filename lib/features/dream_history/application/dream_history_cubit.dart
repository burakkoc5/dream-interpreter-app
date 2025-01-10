import 'package:cloud_firestore/cloud_firestore.dart';
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
          lastDocument: null,
        ));
      } else {
        emit(state.copyWith(isLoading: true, error: null));
      }

      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulate loading
      final userId = _authCubit.state.user?.id;
      print('User ID: $userId');
      if (userId == null) throw Exception('User not authenticated');

      final result = await _repository.getDreamHistory(
        userId,
        lastDocument: refresh ? null : state.lastDocument,
      );
      //print('Result: $result this is the result');
      final dreamsData = result['dreams'];
      List<DreamHistoryModel> dreams;
      if (dreamsData == null || (dreamsData is! List) || dreamsData.isEmpty) {
        print("Dreams data is empty or invalid");
        dreams = [];
      } else {
        dreams = (dreamsData as List<DreamHistoryModel>).toList();
        print('Dreams: $dreams this line is the dreams');
      }

      final lastDocument = result['lastDocument'] as DocumentSnapshot?;
      final isNewData = result['isNewData'] as bool;

      if (isNewData) {
        emit(state.copyWith(
          dreams: [...state.dreams, ...dreams],
          lastDocument: lastDocument,
          isLoading: false,
          hasMore: dreams.length >= 10,
        ));
        _applyFilters();
      } else {
        emit(state.copyWith(isLoading: false)); // No changes needed
      }
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

      final result = await _repository.getDreamHistory(
        userId,
        lastDocument: state.lastDocument,
      );

      final moreDreams = result['dreams'] as List<DreamHistoryModel>;
      final lastDocument = result['lastDocument'] as DocumentSnapshot?;
      print('More dreams: ${moreDreams.length}');
      emit(state.copyWith(
        dreams: [...state.dreams, ...moreDreams],
        isLoadingMore: false,
        hasMore: moreDreams.length >= 10,
        lastDocument: lastDocument, // Update the last document
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

  void reset() {
    emit(
      const DreamHistoryState(
        dreams: [],
        filteredDreams: [],
        selectedFilter: 'All',
        searchQuery: '',
        isLoading: false,
        isLoadingMore: false,
        hasMore: true,
        lastDocument: null,
        currentPage: 0,
      ),
    );
  }
}
