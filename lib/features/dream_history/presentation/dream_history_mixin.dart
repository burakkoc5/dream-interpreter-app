import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/dream_card_widget.dart';
import 'package:dream/shared/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    context.read<DreamHistoryCubit>().loadDreams();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBarWidget(
        controller: searchController,
        hintText: t.searchDreams.searchDreams,
        onChanged: (query) =>
            context.read<DreamHistoryCubit>().updateSearchQuery(query),
        onClear: () {
          searchController.clear();
          context.read<DreamHistoryCubit>().updateSearchQuery('');
        },
      ),
    );
  }

  Widget buildFilterChips(BuildContext context, DreamHistoryState state) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filterOptions.map((filter) {
          final isSelected = state.selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) =>
                  context.read<DreamHistoryCubit>().updateFilter(filter),
              selectedColor: theme.colorScheme.primaryContainer,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              labelStyle: TextStyle(
                color: isSelected
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildDreamsList(BuildContext context, DreamHistoryState state) {
    final theme = Theme.of(context);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<DreamHistoryCubit>().loadDreams(),
              child: Text(t.searchDreams.retryButton),
            ),
          ],
        ),
      );
    }

    if (state.filteredDreams.isEmpty) {
      return Center(
        child: Text(
          t.searchDreams.noResults,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<DreamHistoryCubit>().loadDreams(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
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
              onTap: () {
                context.push(
                  AppRoute.dreamDetail,
                  extra: dream,
                );
              },
              onDelete: () {
                context.read<DreamHistoryCubit>().deleteDream(dream.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Delete ${dream.title}?'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () =>
                          context.read<DreamHistoryCubit>().loadDreams(),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
