import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/dream_entry_model.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/shared/widgets/mood_rating_widget.dart';
import 'tag_input_section.dart';
import 'available_tags_section.dart';
import 'selected_tags_section.dart';
import 'package:dream/shared/widgets/app_button.dart';

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
    // Load all available tags when the modal opens
    context.read<DreamHistoryCubit>().updateAvailableTags();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final bottomNavBarHeight =
        MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.dreamEntry.dreamDetails.addDetails,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Title Input
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        child: TextField(
                          controller: _titleController,
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            labelText: t.dreamEntry.dreamTitle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Tags Section
                      Text(
                        t.dreamEntry.tags.tags,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TagInputSection(
                        tagController: _tagController,
                        onAddTag: _addTag,
                      ),
                      const SizedBox(height: 16),
                      // Previously used tags section
                      if (context
                          .watch<DreamHistoryCubit>()
                          .state
                          .availableTags
                          .isNotEmpty) ...[
                        const SizedBox(height: 24),
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
                        const SizedBox(height: 16),
                        SelectedTagsSection(
                          tags: _tags,
                          onTagRemoved: _removeTag,
                        ),
                      ],
                      const SizedBox(height: 24),
                      // Mood Rating Section
                      Text(
                        t.dreamEntry.dreamDetails.moodRating,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      MoodRatingWidget(
                        rating: _moodRating,
                        onRatingChanged: (rating) =>
                            setState(() => _moodRating = rating),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Action Button
              Container(
                padding: EdgeInsets.fromLTRB(
                    24, 16, 24, bottomPadding + bottomNavBarHeight + 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.1),
                    ),
                  ),
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
                  height: 44,
                  width: double.infinity,
                  variant: AppButtonVariant.primary,
                ),
              ),
            ],
          ),
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
