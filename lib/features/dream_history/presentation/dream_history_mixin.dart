import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:dream/features/dream_history/presentation/widgets/delete_dream_alert_dialog.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/dream_card_widget.dart';
import 'package:dream/shared/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

import 'package:toastification/toastification.dart';

mixin DreamHistoryMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController searchController = TextEditingController();

  final List<String> filterOptions = [
    t.dreamFilterOptions.all,
    t.dreamFilterOptions.week,
    t.dreamFilterOptions.month,
    t.dreamFilterOptions.favorites
  ];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DreamHistoryCubit>();
    debugPrint('DreamHistoryMixin - Initial load of dreams');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.loadDreams(refresh: true);
    });
  }

  void _showSuccessToast(String message) {
    if (!mounted) return;

    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: Text('Başarılı'),
      description: Text(message),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget buildSearchBar(BuildContext context) {
    return SearchBarWidget(
      controller: searchController,
      hintText: t.searchDreams.searchDreams,
      onChanged: (query) =>
          context.read<DreamHistoryCubit>().updateSearchQuery(query),
      onClear: () {
        searchController.clear();
        context.read<DreamHistoryCubit>().updateSearchQuery('');
      },
    );
  }

  Widget buildFilterChips(BuildContext context, DreamHistoryState state) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        ...filterOptions.map((filter) {
          final isSelected = state.selectedFilter == filter;
          return FilterChip(
            label: Text(
              filter,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
            selected: isSelected,
            onSelected: (_) => context.read<DreamHistoryCubit>().updateFilter(
                  isSelected ? t.dreamFilterOptions.all : filter,
                ),
            selectedColor: theme.colorScheme.primaryContainer.withOpacity(0.8),
            backgroundColor: theme.colorScheme.surface.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withOpacity(0.1),
                width: 0.5,
              ),
            ),
          );
        }),
        if (state.availableTags.isNotEmpty)
          FilterChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_offer_rounded,
                  size: 13,
                  color: state.selectedTags.isNotEmpty
                      ? theme.colorScheme.onSecondaryContainer
                      : theme.colorScheme.onSurface,
                ),
                const SizedBox(width: 4),
                Text(
                  state.selectedTags.isEmpty
                      ? t.dreamFilterOptions.tags
                      : '${state.selectedTags.length} ${t.dreamFilterOptions.tags}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: state.selectedTags.isNotEmpty
                        ? theme.colorScheme.onSecondaryContainer
                        : theme.colorScheme.onSurface,
                    fontWeight: state.selectedTags.isNotEmpty
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
                if (state.selectedTags.isNotEmpty) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.close,
                    size: 13,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ],
              ],
            ),
            selected: state.selectedTags.isNotEmpty,
            onSelected: (_) => _showTagFilterDialog(context, state),
            selectedColor: theme.colorScheme.secondaryContainer,
            backgroundColor: theme.colorScheme.surface.withOpacity(0.2),
            showCheckmark: false,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: state.selectedTags.isNotEmpty
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withOpacity(0.1),
                width: 0.5,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _showTagFilterDialog(
      BuildContext context, DreamHistoryState state) async {
    final theme = Theme.of(context);

    await showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: BlocBuilder<DreamHistoryCubit, DreamHistoryState>(
          builder: (context, state) => AlertDialog(
            backgroundColor: theme.colorScheme.surface.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.local_offer_rounded,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  t.dreamFilterOptions.selectTag,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: state.selectedTags.isNotEmpty
                      ? () {
                          context.read<DreamHistoryCubit>().clearSelectedTags();
                        }
                      : null,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    t.dreamFilterOptions.all,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: state.selectedTags.isNotEmpty
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface.withOpacity(0.38),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            content: SingleChildScrollView(
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  ...state.availableTags.map((tag) {
                    final isSelected = state.selectedTags.contains(tag);
                    return Container(
                      padding: const EdgeInsets.only(top: 8),
                      decoration: isSelected
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.secondary
                                      .withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            )
                          : null,
                      child: FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: theme.colorScheme.onSecondaryContainer,
                                ),
                              ),
                            Text(
                              tag,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isSelected
                                    ? theme.colorScheme.onSecondaryContainer
                                    : theme.colorScheme.onSurface,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? theme.colorScheme.onSecondaryContainer
                                        .withOpacity(0.2)
                                    : theme.colorScheme.onSurface
                                        .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${state.tagCounts[tag] ?? 0}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isSelected
                                      ? theme.colorScheme.onSecondaryContainer
                                      : theme.colorScheme.onSurface
                                          .withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          context
                              .read<DreamHistoryCubit>()
                              .updateSelectedTag(tag);
                        },
                        selectedColor: theme.colorScheme.secondaryContainer,
                        backgroundColor:
                            theme.colorScheme.surface.withOpacity(0.2),
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? theme.colorScheme.secondary
                                : theme.colorScheme.outline.withOpacity(0.3),
                            width: 0.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDreamsList(
    BuildContext context,
    DreamHistoryState state, {
    ScrollController? scrollController,
  }) {
    final theme = Theme.of(context);

    if (state.isLoading && state.dreams.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              state.error!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                debugPrint('DreamHistoryMixin - Manual refresh of dreams');
                context.read<DreamHistoryCubit>().loadDreams(refresh: true);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.filteredDreams.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          debugPrint(
              'DreamHistoryMixin - Pull-to-refresh of empty dreams list');
          await context.read<DreamHistoryCubit>().loadDreams(refresh: true);
        },
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.nights_stay_outlined,
                      size: 48,
                      color: theme.colorScheme.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.searchDreams.noResults,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        debugPrint('DreamHistoryMixin - Pull-to-refresh of dreams');
        await context.read<DreamHistoryCubit>().loadDreams(refresh: true);
      },
      backgroundColor: theme.colorScheme.surface.withOpacity(0.9),
      color: theme.colorScheme.primary,
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemCount: state.filteredDreams.length,
        itemBuilder: (context, index) {
          final dream = state.filteredDreams[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DreamCard(
              title: dream.title,
              dreamContent: dream.content,
              interpretation: dream.interpretation,
              date: dream.createdAt,
              moodRating: dream.moodRating,
              isFavourite: dream.isFavourite,
              onFavoriteToggle: () {
                context.read<DreamHistoryCubit>().toggleFavorite(dream);
              },
              onTap: () {
                context.push(
                  AppRoute.dreamDetail,
                  extra: dream,
                );
              },
              onDelete: () async {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: DeleteDreamAlertDialog(theme: theme, dream: dream),
                  ),
                );

                if (shouldDelete == true && mounted) {
                  debugPrint('DreamHistoryMixin - Deleting dream ${dream.id}');
                  context.read<DreamHistoryCubit>().deleteDream(dream.id);
                  _showSuccessToast(t.searchDreams.dreamDeleted);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
