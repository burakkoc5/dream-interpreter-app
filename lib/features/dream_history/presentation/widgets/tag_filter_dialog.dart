import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/features/dream_history/presentation/widgets/dialog_tag_chip.dart';
import 'package:dream/features/dream_history/presentation/widgets/tag_dialog_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

class TagFilterDialog extends StatelessWidget {
  const TagFilterDialog({
    super.key,
    required this.state,
  });

  final DreamHistoryState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print(state.tagCounts);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: BlocBuilder<DreamHistoryCubit, DreamHistoryState>(
        builder: (context, state) => AlertDialog(
          backgroundColor: theme.colorScheme.surface.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: TagDialogHeader(
            hasSelectedTags: state.selectedTags.isNotEmpty,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                ...state.availableTags.map((tag) {
                  final isSelected = state.selectedTags.contains(tag);
                  return DialogTagChip(
                    tag: tag,
                    count: state.tagCounts[tag] ?? 0,
                    isSelected: isSelected,
                    onSelected: (_) {
                      context.read<DreamHistoryCubit>().updateSelectedTag(tag);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
