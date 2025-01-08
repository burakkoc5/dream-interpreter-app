import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import '../models/dream_entry_model.dart';

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
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
          if (_tags.isNotEmpty) ...[
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              5,
              (index) => IconButton(
                onPressed: () => setState(() => _moodRating = index + 1),
                icon: Icon(
                  index < _moodRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
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
