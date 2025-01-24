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
            color: theme.colorScheme.surface
                .withValues(alpha: isDarkMode ? 0.4 : 0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
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
                            .withValues(alpha: isDarkMode ? 0.2 : 0.1),
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
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
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
                        theme.colorScheme.primary.withValues(alpha: 0.3),
                    inactiveThumbColor:
                        theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    inactiveTrackColor:
                        theme.colorScheme.onSurface.withValues(alpha: 0.2),
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
                      ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                      : theme.colorScheme.onSurface.withValues(alpha: 0.2),
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
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
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
                    value: !(profile.preferences['closeBackgroundAnimation']
                            as bool? ??
                        true),
                    onChanged: (enabled) {
                      context.read<ProfileCubit>().updateProfilePreferences({
                        'preferences': {
                          ...profile.preferences,
                          'closeBackgroundAnimation': !enabled,
                        }
                      });
                    },
                    activeColor: theme.colorScheme.primary,
                    activeTrackColor:
                        theme.colorScheme.primary.withValues(alpha: 0.3),
                    inactiveThumbColor:
                        theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    inactiveTrackColor:
                        theme.colorScheme.onSurface.withValues(alpha: 0.2),
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
                  await context.read<AuthCubit>().signOut(context);
                  debugPrint('AuthCubit: Signing out');
                  if (context.mounted) {
                    debugPrint('DreamEntryCubit: Resetting dream entry');
                    context.read<DreamEntryCubit>().reset();
                    debugPrint('DreamHistoryCubit: Resetting dream history');
                    context.read<DreamHistoryCubit>().reset();
                    debugPrint('Navigating to login');
                    context.go(AppRoute.login);
                  }
                },
              ),
              _buildDivider(context),
              _buildSettingItem(
                context,
                icon: Icons.delete_forever_outlined,
                title: t.profile.deleteAccount.title,
                onTap: () => _showDeleteAccountConfirmation(context),
                textColor: theme.colorScheme.error,
                iconColor: theme.colorScheme.error,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showDeleteAccountConfirmation(BuildContext context) async {
    final theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.warning_rounded,
          color: theme.colorScheme.error,
          size: 32,
        ),
        title: Text(
          t.profile.deleteAccount.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.profile.deleteAccount.message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'This action cannot be undone.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 8, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.outline),
                  ),
                  child: Text(
                    t.common.cancel,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    if (context.mounted) {
                      await context.read<AuthCubit>().deleteAccount(context);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                  child: Text(t.profile.deleteAccount.confirm),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<AuthCubit>().deleteAccount(context);
    }
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    Color? textColor,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final isDisabled = onTap == null;
    final effectiveTextColor = textColor ?? theme.colorScheme.onSurface;
    final effectiveIconColor = iconColor ?? theme.colorScheme.primary;

    return ListTile(
      enabled: !isDisabled,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: effectiveIconColor.withValues(alpha: isDisabled ? 0.05 : 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: effectiveIconColor.withValues(alpha: isDisabled ? 0.5 : 1.0),
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: effectiveTextColor.withValues(alpha: isDisabled ? 0.5 : 1.0),
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
      color: theme.colorScheme.primary.withValues(alpha: 0.1),
      height: 1,
      indent: 12,
      endIndent: 12,
    );
  }
}
