import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/profile_model.dart';
import 'profile_photo_picker_widget.dart';
import 'editable_name_section.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
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

class EditableProfileHeader extends StatelessWidget {
  final Profile profile;
  final Function(String) onDisplayNameChanged;

  const EditableProfileHeader({
    super.key,
    required this.profile,
    required this.onDisplayNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfilePhotoPickerWidget(
              currentPhotoUrl: profile.photoUrl,
              onPhotoSelected: (photoUrl) {
                context.read<ProfileCubit>().updateProfilePhoto(photoUrl);
              },
            ),
            const SizedBox(height: 16),
            EditableNameSection(
              initialName: profile.displayName!,
              onNameChanged: onDisplayNameChanged,
            ),
            const SizedBox(height: 8),
            Text(profile.email),
          ],
        ),
      ),
    );
  }
}
