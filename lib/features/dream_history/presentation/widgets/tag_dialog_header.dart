import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagDialogHeader extends StatelessWidget {
  const TagDialogHeader({
    super.key,
    required this.hasSelectedTags,
  });

  final bool hasSelectedTags;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
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
          onPressed: hasSelectedTags
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
              color: hasSelectedTags
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.38),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
