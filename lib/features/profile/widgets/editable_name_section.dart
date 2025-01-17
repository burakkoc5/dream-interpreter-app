import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class EditableNameSection extends StatefulWidget {
  const EditableNameSection({
    super.key,
    required this.initialName,
    required this.onNameChanged,
  });

  final String initialName;
  final ValueChanged<String> onNameChanged;

  @override
  State<EditableNameSection> createState() => _EditableNameSectionState();
}

class _EditableNameSectionState extends State<EditableNameSection> {
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveDisplayName() {
    if (_nameController.text.trim().isNotEmpty) {
      widget.onNameChanged(_nameController.text.trim());
      setState(() => _isEditing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: t.profile.username,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveDisplayName,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.initialName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => setState(() => _isEditing = true),
        ),
      ],
    );
  }
}
