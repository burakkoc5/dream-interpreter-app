import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/theme_toggle_button.dart';
import 'package:dream/shared/widgets/language_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/profile_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:dream/config/theme/theme_cubit.dart';

/// Widget displaying settings options in a list format
class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        if (profile == null) return const SizedBox.shrink();

        return Container(
          decoration: BoxDecoration(
            color:
                theme.colorScheme.surface.withOpacity(isDarkMode ? 0.4 : 0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary
                            .withOpacity(isDarkMode ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.settings,
                        color: theme.colorScheme.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t.profile.settings,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                minVerticalPadding: 0,
                visualDensity: VisualDensity.compact,
                leading: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                ),
                title: Text(
                  t.profile.notifications,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch.adaptive(
                    value: profile.notificationsEnabled,
                    onChanged: (enabled) {
                      context.read<ProfileCubit>().updateNotifications(enabled);
                    },
                    activeColor: theme.colorScheme.primary,
                    activeTrackColor:
                        theme.colorScheme.primary.withOpacity(0.3),
                    inactiveThumbColor:
                        theme.colorScheme.onSurface.withOpacity(0.8),
                    inactiveTrackColor:
                        theme.colorScheme.onSurface.withOpacity(0.2),
                  ),
                ),
              ),
              _buildDivider(context),
              _buildSettingItem(
                context,
                icon: Icons.notification_add,
                title: t.dreamEntry.dreamForm.record,
                onTap: profile.notificationsEnabled
                    ? () => context.push(AppRoute.reminderSettings)
                    : null,
                trailing: Icon(
                  Icons.chevron_right,
                  color: profile.notificationsEnabled
                      ? theme.colorScheme.onSurface.withOpacity(0.5)
                      : theme.colorScheme.onSurface.withOpacity(0.2),
                ),
              ),
              _buildDivider(context),
              const ThemeToggleButton(),
              _buildDivider(context),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                minVerticalPadding: 0,
                visualDensity: VisualDensity.compact,
                leading: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.animation,
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                ),
                title: Text(
                  t.profile.closeBackgroundAnimation,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch.adaptive(
                    value: profile.preferences['closeBackgroundAnimation']
                            as bool? ??
                        true,
                    onChanged: (enabled) {
                      context.read<ProfileCubit>().updateProfilePreferences({
                        'preferences': {
                          ...profile.preferences,
                          'closeBackgroundAnimation': enabled,
                        }
                      });
                    },
                    activeColor: theme.colorScheme.primary,
                    activeTrackColor:
                        theme.colorScheme.primary.withOpacity(0.3),
                    inactiveThumbColor:
                        theme.colorScheme.onSurface.withOpacity(0.8),
                    inactiveTrackColor:
                        theme.colorScheme.onSurface.withOpacity(0.2),
                  ),
                ),
              ),
              _buildDivider(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: const LanguageSelector(),
              ),
              _buildDivider(context),
              _buildSettingItem(
                context,
                icon: Icons.lock,
                title: t.profile.changePassword,
                onTap: () => context.push(AppRoute.changePassword),
              ),
              _buildDivider(context),
              _buildSettingItem(
                context,
                icon: Icons.logout,
                title: t.profile.logout,
                onTap: () async {
                  await context.read<AuthCubit>().signOut();
                  if (context.mounted) {
                    context.read<DreamEntryCubit>().reset();
                    context.read<DreamHistoryCubit>().reset();
                    context.go(AppRoute.login);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    final isDisabled = onTap == null;

    return ListTile(
      enabled: !isDisabled,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(isDisabled ? 0.05 : 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: theme.colorScheme.primary.withOpacity(isDisabled ? 0.5 : 1.0),
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color:
              theme.colorScheme.onSurface.withOpacity(isDisabled ? 0.5 : 1.0),
          fontSize: 14,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Divider(
      color: theme.colorScheme.primary.withOpacity(0.1),
      height: 1,
      indent: 12,
      endIndent: 12,
    );
  }
}
