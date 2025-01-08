import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/profile_model.dart';
import 'profile_photo_picker_widget.dart';

/// Widget displaying the user's profile header with photo and basic info
class ProfileHeaderWidget extends StatelessWidget {
  final Profile profile;

  const ProfileHeaderWidget({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ProfilePhotoPickerWidget(
              currentPhotoUrl: profile.photoUrl,
              onPhotoSelected: (photoUrl) {
                context.read<ProfileCubit>().updateProfilePhoto(photoUrl);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          profile.displayName!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          profile.email,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class EditableProfileHeader extends StatefulWidget {
  final Profile profile;
  final Function(String) onDisplayNameChanged;

  const EditableProfileHeader({
    super.key,
    required this.profile,
    required this.onDisplayNameChanged,
  });

  @override
  State<EditableProfileHeader> createState() => _EditableProfileHeaderState();
}

class _EditableProfileHeaderState extends State<EditableProfileHeader> {
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.displayName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveDisplayName() {
    if (_nameController.text.trim().isNotEmpty) {
      widget.onDisplayNameChanged(_nameController.text.trim());
      setState(() => _isEditing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfilePhotoPickerWidget(
              currentPhotoUrl: widget.profile.photoUrl,
              onPhotoSelected: (photoUrl) {
                context.read<ProfileCubit>().updateProfilePhoto(photoUrl);
              },
            ),
            const SizedBox(height: 16),
            if (_isEditing)
              Row(
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
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.profile.displayName!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => setState(() => _isEditing = true),
                  ),
                ],
              ),
            const SizedBox(height: 8),
            Text(widget.profile.email),
          ],
        ),
      ),
    );
  }
}
