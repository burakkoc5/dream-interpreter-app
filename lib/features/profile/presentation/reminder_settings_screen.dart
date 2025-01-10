import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/features/profile/widgets/reminder_settings_content.dart';
import 'package:dream/shared/repositories/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../models/reminder_settings_model.dart';

class ReminderSettingsScreen extends StatelessWidget {
  const ReminderSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null) return Center(child: Text(state.error!));

        final profile = state.profile;
        if (profile == null) {
          return const Center(child: Text('Profile not found'));
        }

        final currentSettings = profile.preferences['reminderSettings'];
        final ReminderSettings? settings = currentSettings != null
            ? ReminderSettings.fromJson(currentSettings as Map<String, dynamic>)
            : null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Set dream reminder time'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: ReminderSettingsContent(
            initialSettings: settings,
            onSave: (selectedSettings) async {
              await context
                  .read<ProfileCubit>()
                  .updateReminders(selectedSettings);
              context.mounted
                  ? await context
                      .read<NotificationRepository>()
                      .scheduleDreamReminder(
                        time: selectedSettings.time,
                      )
                  : null;
              if (context.mounted) context.pop(selectedSettings);
            },
          ),
        );
      },
    );
  }
}
