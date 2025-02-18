import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/features/dream_history/presentation/widgets/dream_filter_chips.dart';
import 'package:dream/features/dream_history/presentation/widgets/dream_history_content.dart';
import 'package:dream/features/dream_history/presentation/widgets/dream_history_skeletonizer.dart';
import 'package:dream/features/dream_history/presentation/widgets/dream_list_error.dart';
import 'package:dream/features/dream_history/presentation/widgets/empty_dream_list.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin DreamHistoryMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController searchController = TextEditingController();

  final List<String> filterOptions = [
    t.dreamFilterOptions.all,
    t.dreamFilterOptions.week,
    t.dreamFilterOptions.month,
    t.dreamFilterOptions.favorites,
  ];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DreamHistoryCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.loadDreams(refresh: true);
    });
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
    if (state.availableTags.isNotEmpty &&
        !filterOptions.contains(t.dreamFilterOptions.tags)) {
      filterOptions.add(t.dreamFilterOptions.tags);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            DreamFilterChips(
              state: state,
              filterOptions: filterOptions,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDreamsList(BuildContext context, DreamHistoryState state,
      {ScrollController? scrollController}) {
    if (state.isLoading) {
      return const DreamHistorySkeletonizer();
    }

    if (state.error != null) {
      return DreamListError(error: state.error!);
    }

    if (state.filteredDreams.isEmpty) {
      return const EmptyDreamList();
    }

    return DreamHistoryContent(
      theme: Theme.of(context),
      scrollController: scrollController,
      state: state,
      context: context,
    );
  }
}
