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
    final theme = Theme.of(context);

    if (_isEditing) {
      return Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: t.profile.username,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                textAlign: TextAlign.start,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.check,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              onPressed: _saveDisplayName,
            ),
          ],
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            widget.initialName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: Icon(
              Icons.edit,
              size: 18,
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            onPressed: () => setState(() => _isEditing = true),
          ),
        ),
      ],
    );
  }
}
