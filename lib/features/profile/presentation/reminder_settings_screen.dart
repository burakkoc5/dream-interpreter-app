import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/features/profile/widgets/reminder_settings_content.dart';
import 'package:dream/shared/repositories/notification_repository.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../models/reminder_settings_model.dart';
import 'package:dream/config/theme/theme_cubit.dart';
import 'dart:ui';

class ReminderSettingsScreen extends StatelessWidget {
  const ReminderSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.error != null) {
          return Scaffold(
            body: Center(child: Text(state.error!)),
          );
        }

        final profile = state.profile;
        if (profile == null) {
          return Scaffold(
            body: Center(child: Text(t.profile.profileNotFound)),
          );
        }

        final currentSettings = profile.preferences['reminderSettings'];
        final ReminderSettings? settings = currentSettings != null
            ? ReminderSettings.fromJson(currentSettings as Map<String, dynamic>)
            : null;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              t.profile.reminder.setTime,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: theme.colorScheme.surface.withOpacity(0.5),
                ),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color:
                  theme.colorScheme.surface.withOpacity(isDarkMode ? 0.4 : 0.7),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: ReminderSettingsContent(
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
              ),
            ),
          ),
        );
      },
    );
  }
}
