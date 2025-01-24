import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/features/dream_history/presentation/widgets/dialog_tag_chip.dart';
import 'package:flutter/material.dart';

class AvailableTagsSection extends StatelessWidget {
  const AvailableTagsSection({
    super.key,
    required this.state,
    required this.selectedTags,
    required this.onTagSelected,
  });

  final DreamHistoryState state;
  final List<String> selectedTags;
  final Function(String) onTagSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (state.availableTags.isEmpty) return const SizedBox.shrink();

    debugPrint(state.tagCounts.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Previously used tags',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            ...state.availableTags.map((tag) {
              final isSelected = state.selectedTags.contains(tag);
              return DialogTagChip(
                tag: tag,
                count: state.tagCounts[tag] ?? 0,
                isSelected: isSelected,
                onSelected: (_) => onTagSelected(tag),
              );
            }),
          ],
        ),
      ],
    );
  }
}
