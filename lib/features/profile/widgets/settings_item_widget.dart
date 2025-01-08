import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/profile_cubit.dart';
import 'package:go_router/go_router.dart';

/// Widget displaying settings options in a list format
class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        if (profile == null) return const SizedBox.shrink();

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.profile.settings,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(t.profile.notifications),
                  trailing: Switch(
                    value: profile.notificationsEnabled,
                    onChanged: (enabled) {
                      context.read<ProfileCubit>().updateNotifications(enabled);
                    },
                  ),
                ),
                const ThemeToggleButton(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.lock),
                  title: Text(t.profile.changePassword),
                  onTap: () => context.push(AppRoute.changePassword),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.logout),
                  title: Text(t.profile.logout),
                  textColor: Colors.red,
                  iconColor: Colors.red,
                  onTap: () {
                    context.read<AuthCubit>().signOut();
                    context.go(AppRoute.login);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
