import 'package:flutter/material.dart';

class SelectedTagsSection extends StatelessWidget {
  const SelectedTagsSection({
    super.key,
    required this.tags,
    required this.onTagRemoved,
  });

  final List<String> tags;
  final Function(String) onTagRemoved;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected tags',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: tags
              .map((tag) => Chip(
                    label: Text(tag),
                    onDeleted: () => onTagRemoved(tag),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
