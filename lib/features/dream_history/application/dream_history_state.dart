import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class DreamHistoryState {
  final List<DreamHistoryModel> dreams;
  final List<DreamHistoryModel> filteredDreams;
  final String selectedFilter;
  final String searchQuery;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final DocumentSnapshot? lastDocument;
  final int currentPage;
  final List<String> availableTags;
  final List<String> selectedTags;
  final Map<String, int> tagCounts;

  const DreamHistoryState({
    this.dreams = const [],
    this.filteredDreams = const [],
    this.selectedFilter = 'All',
    this.searchQuery = '',
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.lastDocument,
    this.currentPage = 0,
    this.availableTags = const [],
    this.selectedTags = const [],
    this.tagCounts = const {},
  });

  DreamHistoryState copyWith({
    List<DreamHistoryModel>? dreams,
    List<DreamHistoryModel>? filteredDreams,
    String? selectedFilter,
    String? searchQuery,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    DocumentSnapshot? lastDocument,
    int? currentPage,
    List<String>? availableTags,
    List<String>? selectedTags,
    Map<String, int>? tagCounts,
  }) {
    return DreamHistoryState(
      dreams: dreams ?? this.dreams,
      filteredDreams: filteredDreams ?? this.filteredDreams,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      lastDocument: lastDocument,
      currentPage: currentPage ?? this.currentPage,
      availableTags: availableTags ?? this.availableTags,
      selectedTags: selectedTags ?? this.selectedTags,
      tagCounts: tagCounts ?? this.tagCounts,
    );
  }
}
