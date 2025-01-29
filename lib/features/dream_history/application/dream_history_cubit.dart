import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/dream_history_repository.dart';
import 'dream_history_state.dart';
import 'package:injectable/injectable.dart';
import 'package:dream/i18n/strings.g.dart';

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
          filteredDreams: [],
          hasMore: true,
          lastDocument: null,
        ));
      } else {
        emit(state.copyWith(isLoading: true, error: null));
      }

      String? userId = _authCubit.state.user?.id;

      // If userId is null, wait a bit longer and retry multiple times
      int retryCount = 0;
      while (userId == null && retryCount < 3) {
        await Future.delayed(const Duration(milliseconds: 300));
        userId = _authCubit.state.user?.id;
        retryCount++;
      }

      if (userId == null) {
        emit(state.copyWith(
          error: t.core.errors.userNotAuthenticated,
          isLoading: false,
          dreams: [],
          filteredDreams: [],
        ));
        return;
      }

      final result = await _repository.getDreamHistory(
        userId,
        lastDocument: state.lastDocument,
      );

      final dreamsData = result['dreams'];
      List<DreamHistoryModel> dreams;
      if (dreamsData == null || (dreamsData is! List) || dreamsData.isEmpty) {
        dreams = [];
      } else {
        dreams = (dreamsData as List<DreamHistoryModel>).toList();
      }

      final lastDocument = result['lastDocument'] as DocumentSnapshot?;
      final isNewData = result['isNewData'] as bool;

      if (isNewData) {
        final updatedDreams = refresh ? dreams : [...state.dreams, ...dreams];

        emit(state.copyWith(
          dreams: updatedDreams,
          filteredDreams: [], // Clear filtered dreams to force reapplication of filters
          lastDocument:
              lastDocument, // Always update lastDocument for proper pagination
          isLoading: false,
          hasMore: dreams.length >= 10,
          error: null,
        ));
        updateAvailableTags();
        _applyFilters(); // This will update filteredDreams
      } else {
        emit(state.copyWith(
          isLoading: false,
          hasMore: false,
          error: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load dreams: $e',
        isLoading: false,
      ));
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

      // Check if we actually have new dreams
      final currentDreamsIds = state.dreams.map((d) => d.id).toSet();
      final newDreamsIds = moreDreams.map((d) => d.id).toSet();

      if (newDreamsIds.any((id) => !currentDreamsIds.contains(id))) {
        emit(state.copyWith(
          dreams: [...state.dreams, ...moreDreams],
          filteredDreams: [], // Clear filtered dreams to force reapplication of filters
          isLoadingMore: false,
          hasMore: moreDreams.length >= 10,
          lastDocument: lastDocument, // Update lastDocument for next pagination
        ));
        _applyFilters(); // This will update filteredDreams
      } else {
        emit(state.copyWith(
          isLoadingMore: false,
          hasMore: false, // No more unique dreams to load
        ));
      }
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
      // Force a complete refresh of the dreams list
      emit(state.copyWith(
        lastDocument: null,
        dreams: [],
        filteredDreams: [],
      ));
      await loadDreams(refresh: true);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to delete dream: $e'));
    }
  }

  Future<void> toggleFavorite(DreamHistoryModel dream) async {
    try {
      final updatedDream = dream.copyWith(isFavourite: !dream.isFavourite);
      await _repository.updateDream(updatedDream);

      // Update the dream in the state
      final updatedDreams = state.dreams.map((d) {
        if (d.id == dream.id) {
          return updatedDream;
        }
        return d;
      }).toList();

      emit(state.copyWith(dreams: updatedDreams));
      _applyFilters();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update favorite status: $e'));
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
    final translations = t;
    if (state.selectedFilter == translations.dreamFilterOptions.week) {
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      filteredDreams = filteredDreams
          .where((dream) => dream.createdAt.isAfter(weekAgo))
          .toList();
    } else if (state.selectedFilter == translations.dreamFilterOptions.month) {
      final monthAgo = DateTime.now().subtract(const Duration(days: 30));
      filteredDreams = filteredDreams
          .where((dream) => dream.createdAt.isAfter(monthAgo))
          .toList();
    } else if (state.selectedFilter ==
        translations.dreamFilterOptions.favorites) {
      filteredDreams =
          filteredDreams.where((dream) => dream.isFavourite).toList();
    }

    // Apply tag filter
    if (state.selectedTags.isNotEmpty) {
      filteredDreams = filteredDreams
          .where((dream) =>
              dream.tags.any((tag) => state.selectedTags.contains(tag)))
          .toList();
    }

    emit(state.copyWith(filteredDreams: filteredDreams));
  }

  void updateSelectedTag(String tag) {
    final updatedTags = List<String>.from(state.selectedTags);
    if (updatedTags.contains(tag)) {
      updatedTags.remove(tag);
    } else {
      updatedTags.add(tag);
    }
    emit(state.copyWith(selectedTags: updatedTags));
    _applyFilters();
  }

  void clearSelectedTags() {
    emit(state.copyWith(selectedTags: []));
    _applyFilters();
  }

  void updateAvailableTags() {
    final Set<String> tags = {};
    final Map<String, int> counts = {};

    for (final dream in state.dreams) {
      for (final tag in dream.tags) {
        tags.add(tag);
        counts[tag] = (counts[tag] ?? 0) + 1;
      }
    }

    emit(state.copyWith(
      availableTags: tags.toList()..sort(),
      tagCounts: counts,
    ));
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
