import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import '../models/dream_entry_model.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/shared/widgets/mood_rating_widget.dart';
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
  }

  @override
  Widget build(BuildContext context) {
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
            TagInputSection(
              tagController: _tagController,
              onAddTag: _addTag,
            ),
            const SizedBox(height: 16),
            BlocBuilder<DreamHistoryCubit, DreamHistoryState>(
              builder: (context, state) => AvailableTagsSection(
                state: state,
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
            ),
            const SizedBox(height: 16),
            SelectedTagsSection(
              tags: _tags,
              onTagRemoved: _removeTag,
            ),
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
