import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import '../models/dream_entry_model.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/shared/widgets/mood_rating_widget.dart';
import 'package:dream/shared/widgets/modal_container.dart';
import 'package:dream/shared/widgets/input_container.dart';
import 'package:dream/shared/widgets/app_button.dart';
import 'tag_input_section.dart';
import 'available_tags_section.dart';
import 'selected_tags_section.dart';

class DreamDetailsModalContent extends StatefulWidget {
  final DreamEntry dreamEntry;
  final Function(String title, List<String> tags, int moodRating) onConfirm;

  const DreamDetailsModalContent({
    super.key,
    required this.dreamEntry,
    required this.onConfirm,
  });

  @override
  State<DreamDetailsModalContent> createState() =>
      _DreamDetailsModalContentState();
}

class _DreamDetailsModalContentState extends State<DreamDetailsModalContent> {
  final _titleController = TextEditingController();
  final _tagController = TextEditingController();
  final List<String> _tags = [];
  int _moodRating = 3;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.dreamEntry.title;
    _tags.addAll(widget.dreamEntry.tags);
    context.read<DreamHistoryCubit>().updateAvailableTags();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final bottomNavBarHeight =
        MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;

    return ModalContainer(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.dreamEntry.dreamDetails.addDetails,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 28),
                    InputContainer(
                      child: TextField(
                        controller: _titleController,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          letterSpacing: 0.2,
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: t.dreamEntry.dreamTitle,
                          hintStyle: TextStyle(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.5),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      t.dreamEntry.tags.tags,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    InputContainer(
                      child: TagInputSection(
                        tagController: _tagController,
                        onAddTag: _addTag,
                      ),
                    ),
                    if (context
                        .watch<DreamHistoryCubit>()
                        .state
                        .availableTags
                        .isNotEmpty) ...[
                      const SizedBox(height: 28),
                      AvailableTagsSection(
                        state: context.watch<DreamHistoryCubit>().state,
                        selectedTags: _tags,
                        onTagSelected: (tag) {
                          setState(() {
                            if (_tags.contains(tag)) {
                              _tags.remove(tag);
                            } else {
                              _tags.add(tag);
                            }
                          });
                        },
                      ),
                    ],
                    if (_tags.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      SelectedTagsSection(
                        tags: _tags,
                        onTagRemoved: _removeTag,
                      ),
                    ],
                    const SizedBox(height: 32),
                    Text(
                      t.dreamEntry.dreamDetails.moodRating,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: MoodRatingWidget(
                        rating: _moodRating,
                        onRatingChanged: (rating) =>
                            setState(() => _moodRating = rating),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  24, 20, 24, bottomPadding + bottomNavBarHeight + 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: AppButton(
                text: t.dreamEntry.dreamDetails.confirmButton,
                onPressed: () {
                  widget.onConfirm(
                    _titleController.text,
                    _tags,
                    _moodRating,
                  );
                },
                height: 52,
                width: double.infinity,
                variant: AppButtonVariant.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _tagController.dispose();
    super.dispose();
  }
}
