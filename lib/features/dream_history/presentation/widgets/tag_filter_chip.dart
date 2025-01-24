import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class TagFilterChip extends StatelessWidget {
  const TagFilterChip({
    super.key,
    required this.state,
    required this.onSelected,
  });

  final DreamHistoryState state;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
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
      onSelected: (_) => onSelected(),
      selectedColor: theme.colorScheme.secondaryContainer,
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.2),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: state.selectedTags.isNotEmpty
              ? theme.colorScheme.primary
              : theme.colorScheme.primary.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
    );
  }
}
