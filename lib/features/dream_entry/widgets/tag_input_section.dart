import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class TagInputSection extends StatelessWidget {
  const TagInputSection({
    super.key,
    required this.tagController,
    required this.onAddTag,
  });

  final TextEditingController tagController;
  final VoidCallback onAddTag;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: tagController,
            decoration: InputDecoration(
              labelText: t.dreamEntry.dreamDetails.addTags,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onAddTag,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
