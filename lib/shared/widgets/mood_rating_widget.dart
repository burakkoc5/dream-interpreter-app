import 'package:flutter/material.dart';

class MoodRatingWidget extends StatelessWidget {
  final int rating;
  final bool isInteractive;
  final Function(int)? onRatingChanged;
  final double size;

  const MoodRatingWidget({
    super.key,
    required this.rating,
    this.isInteractive = true,
    this.onRatingChanged,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        5,
        (index) {
          IconData moodIcon;
          switch (index) {
            case 0:
              moodIcon = Icons.sentiment_very_dissatisfied;
            case 1:
              moodIcon = Icons.sentiment_dissatisfied;
            case 2:
              moodIcon = Icons.sentiment_neutral;
            case 3:
              moodIcon = Icons.sentiment_satisfied;
            case 4:
              moodIcon = Icons.sentiment_very_satisfied;
            default:
              moodIcon = Icons.sentiment_neutral;
          }

          final isSelected = index < rating;
          final icon = Icon(
            moodIcon,
            color: isSelected
                ? (index == rating - 1
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withValues(alpha: 0.3))
                : theme.colorScheme.onSurface.withValues(alpha: 0.15),
            size: isSelected && index == rating - 1 ? size * 1.1 : size,
          );

          if (!isInteractive) return icon;

          return IconButton(
            icon: icon,
            onPressed: () => onRatingChanged?.call(index + 1),
          );
        },
      ),
    );
  }
}
