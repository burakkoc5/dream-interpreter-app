import 'package:flutter/material.dart';
import '../models/dream_entry_model.dart';

class InterpretationModalContent extends StatefulWidget {
  final DreamEntry dreamEntry;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const InterpretationModalContent({
    super.key,
    required this.dreamEntry,
    required this.onSave,
    required this.onShare,
  });

  @override
  State<InterpretationModalContent> createState() =>
      _InterpretationModalContentState();
}

class _InterpretationModalContentState
    extends State<InterpretationModalContent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dream Interpretation',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            widget.dreamEntry.content,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
          const Divider(height: 32),
          Text(
            'Interpretation',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            widget.dreamEntry.interpretation,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: widget.onSave,
                  icon: const Icon(Icons.save),
                  label: const Text('Saveee'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.onShare,
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
