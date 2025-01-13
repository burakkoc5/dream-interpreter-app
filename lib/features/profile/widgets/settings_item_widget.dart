import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/profile_cubit.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'package:dream/config/theme/theme_cubit.dart';

/// Widget displaying settings options in a list format
class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        if (profile == null) return const SizedBox.shrink();

        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                color: (isDarkMode
                        ? theme.colorScheme.surface
                        : theme.colorScheme.surface)
                    .withOpacity(isDarkMode ? 0.4 : 0.7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary
                              .withOpacity(isDarkMode ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.settings,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        t.profile.settings,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSettingItem(
                    context,
                    icon: Icons.notification_add,
                    title: 'Dream Reminders',
                    onTap: () => context.push(AppRoute.reminderSettings),
                  ),
                  _buildDivider(context),
                  _buildSettingItem(
                    context,
                    icon: Icons.notifications,
                    title: t.profile.notifications,
                    trailing: Switch(
                      value: profile.notificationsEnabled,
                      onChanged: (enabled) {
                        context
                            .read<ProfileCubit>()
                            .updateNotifications(enabled);
                      },
                    ),
                  ),
                  _buildDivider(context),
                  const ThemeToggleButton(),
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
                    textColor: theme.colorScheme.error,
                    iconColor: theme.colorScheme.error,
                    onTap: () {
                      context.read<DreamEntryCubit>().reset();
                      context.read<DreamHistoryCubit>().reset();
                      context.read<AuthCubit>().signOut();
                      context.go(AppRoute.login);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? textColor,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (iconColor ?? theme.colorScheme.primary)
                    .withOpacity(isDarkMode ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor ?? theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: textColor ??
                      theme.colorScheme.onSurface.withOpacity(
                        isDarkMode ? 0.9 : 0.8,
                      ),
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state;

    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0),
            theme.colorScheme.primary.withOpacity(isDarkMode ? 0.1 : 0.05),
            theme.colorScheme.primary.withOpacity(isDarkMode ? 0.1 : 0.05),
            theme.colorScheme.primary.withOpacity(0),
          ],
          stops: const [0.0, 0.2, 0.8, 1.0],
        ),
      ),
    );
  }
}
