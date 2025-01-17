import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import '../models/dream_entry_model.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/shared/widgets/mood_rating_widget.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).size.height * 0.12,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.dreamEntry.dreamDetails.addDetails,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: t.dreamEntry.dreamTitle,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    decoration: InputDecoration(
                      labelText: t.dreamEntry.dreamDetails.addTags,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _addTag,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<DreamHistoryCubit, DreamHistoryState>(
              builder: (context, state) {
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
                        final isSelected = _tags.contains(tag);
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
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? theme.colorScheme.onSecondaryContainer
                                          .withOpacity(0.2)
                                      : theme.colorScheme.onSurface
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${state.tagCounts[tag] ?? 0}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isSelected
                                        ? theme.colorScheme.onSecondaryContainer
                                        : theme.colorScheme.onSurface
                                            .withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              if (isSelected) {
                                _tags.remove(tag);
                              } else {
                                _tags.add(tag);
                              }
                            });
                          },
                          selectedColor: theme.colorScheme.secondaryContainer,
                          backgroundColor:
                              theme.colorScheme.surface.withOpacity(0.2),
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
              },
            ),
            if (_tags.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Selected tags',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          onDeleted: () => _removeTag(tag),
                        ))
                    .toList(),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              t.dreamEntry.dreamDetails.moodRating,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            MoodRatingWidget(
              rating: _moodRating,
              onRatingChanged: (rating) => setState(() => _moodRating = rating),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  widget.onConfirm(
                    _titleController.text,
                    _tags,
                    _moodRating,
                  );
                },
                child: Text(t.dreamEntry.dreamDetails.confirmButton),
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
