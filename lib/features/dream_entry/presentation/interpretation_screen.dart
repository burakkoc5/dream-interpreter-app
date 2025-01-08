import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../models/dream_entry_model.dart';

class InterpretationScreen extends StatefulWidget {
  final DreamEntry dreamEntry;

  const InterpretationScreen({
    super.key,
    required this.dreamEntry,
  });

  @override
  State<InterpretationScreen> createState() => _InterpretationScreenState();
}

class _InterpretationScreenState extends State<InterpretationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final List<String> _selectedTags = [];
  int _moodRating = 0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.dreamEntry.title;
    _selectedTags.addAll(widget.dreamEntry.tags);
    _moodRating = widget.dreamEntry.moodRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.dreamEntry.saveDream),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: t.dreamEntry.dreamTitle,
                hintText: t.dreamEntry.dreamTitleHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t.dreamEntry.yourDream,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(widget.dreamEntry.content),
            const SizedBox(height: 24),
            Text(
              t.dreamEntry.interpretation.interpretationText,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(widget.dreamEntry.interpretation),
            const SizedBox(height: 24),
            Text(
              t.dreamEntry.tags.tags,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 8,
              children: _selectedTags
                  .map((tag) => Chip(
                        label: Text(tag),
                        onDeleted: () =>
                            setState(() => _selectedTags.remove(tag)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Text(
              t.dreamEntry.moodRating,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: Icon(
                    index < _moodRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => _moodRating = index + 1),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveDream,
                child: _isSaving
                    ? const CircularProgressIndicator()
                    : Text(t.dreamEntry.saveDream),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveDream() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.dreamEntry.dreamTitleHint)),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final updatedDream = widget.dreamEntry.copyWith(
        title: _titleController.text,
        tags: _selectedTags,
        moodRating: _moodRating,
      );

      await context.read<DreamEntryCubit>().saveDream(updatedDream);

      if (mounted) {
        context.pop(updatedDream);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(t.dreamEntry.failedToSaveDream + e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
