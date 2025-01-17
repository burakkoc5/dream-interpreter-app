import 'package:dream/features/dream_history/application/dream_history_state.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Previously used tags',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: state.availableTags.map((tag) {
            final isSelected = selectedTags.contains(tag);
            return FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tag,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onSecondaryContainer
                          : theme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.onSecondaryContainer
                              .withOpacity(0.2)
                          : theme.colorScheme.onSurface.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${state.tagCounts[tag] ?? 0}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? theme.colorScheme.onSecondaryContainer
                            : theme.colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => onTagSelected(tag),
              selectedColor: theme.colorScheme.secondaryContainer,
              backgroundColor: theme.colorScheme.surface.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected
                      ? theme.colorScheme.secondary
                      : theme.colorScheme.outline.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
