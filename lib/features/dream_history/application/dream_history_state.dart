import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dream_history_state.freezed.dart';

@freezed
class DreamHistoryState with _$DreamHistoryState {
  const factory DreamHistoryState({
    @Default([]) List<DreamHistoryModel> dreams,
    @Default([]) List<DreamHistoryModel> filteredDreams,
    @Default('All') String selectedFilter,
    @Default('') String searchQuery,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
    DocumentSnapshot? lastDocument,
    @Default(0) int currentPage,
    String? error,
  }) = _DreamHistoryState;
}
