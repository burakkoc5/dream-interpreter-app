import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DreamFilterChips extends StatelessWidget {
  const DreamFilterChips({
    super.key,
    required this.state,
    required this.filterOptions,
  });

  final DreamHistoryState state;
  final List<String> filterOptions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: filterOptions.map((filter) {
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
      }).toList(),
    );
  }
}
