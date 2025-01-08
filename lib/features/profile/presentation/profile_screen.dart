import 'package:dream/core/di/injection.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/features/profile/application/stats_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/stats_card_widget.dart';
import '../widgets/settings_item_widget.dart';

//TODO: Implement notifications feature and update the user preferences.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProfileCubit>()
            ..loadProfile(context.read<AuthCubit>().state.user!.id),
        ),
        BlocProvider(
          create: (context) => getIt<StatsCubit>()
            ..loadStats(context.read<AuthCubit>().state.user!.id),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.profile.profile),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(
                child: Text(
                  state.error!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            }

            final profile = state.profile;
            if (profile == null) {
              return Center(child: Text(t.profile.profileNotFound));
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                EditableProfileHeader(
                  profile: profile,
                  onDisplayNameChanged: (newName) {
                    context
                        .read<ProfileCubit>()
                        .updateDisplayName(newName, profile.userId);
                  },
                ),
                const SizedBox(height: 24),
                const StatsCardWidget(),
                const SizedBox(height: 24),
                const SettingsItemWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
