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
import '../../application/profile_cubit.dart';
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
                title: t.profile.reminder.setTime,
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
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () => _showPrivacyPolicy(context),
              ),
              _buildDivider(context),
              _buildSettingItem(
                context,
                icon: Icons.security,
                title: 'Data Privacy Settings',
                onTap: () => _showDataPrivacySettings(context),
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
                  if (context.mounted) {
                    context.read<DreamEntryCubit>().reset();
                    context.read<DreamHistoryCubit>().reset();
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
                t.profile.deleteAccount.warning,
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

  Future<void> _showPrivacyPolicy(BuildContext context) async {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Privacy Policy',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Data Collection and Usage',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We collect and process the following data:\n'
                '• Dream entries and interpretations\n'
                '• Profile information you provide\n'
                '• App usage statistics\n'
                '• Device information for analytics',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Advertising',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We use rewarded ads that you can choose to watch for additional dream interpretations. These ads are provided by Google AdMob and follow their privacy policies.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Data Protection',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your data is securely stored and protected. We implement appropriate security measures to prevent unauthorized access.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Your Rights',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You have the right to:\n'
                '• Access your data\n'
                '• Request data deletion\n'
                '• Opt out of data collection\n'
                '• Export your data',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              t.common.confirm,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDataPrivacySettings(BuildContext context) async {
    final theme = Theme.of(context);
    final profile = context.read<ProfileCubit>().state.profile;
    if (profile == null) return;

    bool analyticsEnabled = profile.preferences['analyticsEnabled'] ?? true;
    bool personalizationEnabled =
        profile.preferences['personalizationEnabled'] ?? true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Data Privacy Settings',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text(
                  'Analytics Collection',
                  style: theme.textTheme.titleMedium,
                ),
                subtitle: Text(
                  'Allow collection of app usage data to improve our services',
                  style: theme.textTheme.bodySmall,
                ),
                value: analyticsEnabled,
                onChanged: (value) {
                  setState(() => analyticsEnabled = value);
                },
              ),
              SwitchListTile(
                title: Text(
                  'Personalization',
                  style: theme.textTheme.titleMedium,
                ),
                subtitle: Text(
                  'Allow data processing for personalized dream interpretations',
                  style: theme.textTheme.bodySmall,
                ),
                value: personalizationEnabled,
                onChanged: (value) {
                  setState(() => personalizationEnabled = value);
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => _exportUserData(context),
                child: Text(
                  'Export My Data',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                t.common.cancel,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                context.read<ProfileCubit>().updateProfilePreferences({
                  'analyticsEnabled': analyticsEnabled,
                  'personalizationEnabled': personalizationEnabled,
                });
                Navigator.of(context).pop();
              },
              child: Text(
                t.common.confirm,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportUserData(BuildContext context) async {
    // TODO: Implement data export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Your data export will be emailed to you within 24 hours.'),
      ),
    );
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
