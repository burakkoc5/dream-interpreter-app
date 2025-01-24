import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class TagInputSection extends StatelessWidget {
  const TagInputSection({
    super.key,
    required this.tagController,
    required this.onAddTag,
  });

  final TextEditingController tagController;
  final VoidCallback onAddTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: tagController,
            style: theme.textTheme.bodyLarge?.copyWith(
              letterSpacing: 0.2,
              color: theme.colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: t.dreamEntry.dreamDetails.addTags,
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
            ),
            onSubmitted: (_) => onAddTag(),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle,
            color: theme.colorScheme.primary,
          ),
          onPressed: onAddTag,
        ),
      ],
    );
  }
}
