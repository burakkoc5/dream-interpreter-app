import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/features/profile/application/stats_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/stats_card_widget.dart';
import '../widgets/settings_item_widget.dart';
import 'dart:ui';
import 'package:dream/core/presentation/animated_background.dart';
import 'package:dream/features/profile/application/streak_cubit.dart';
import 'package:dream/features/profile/repository/streak_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  late final StatsCubit _statsCubit;
  late final StreakCubit _streakCubit;

  @override
  void initState() {
    super.initState();
    _statsCubit = context.read<StatsCubit>();
    _streakCubit = StreakCubit(repository: StreakRepository());

    final userId = context.read<AuthCubit>().state.user?.id;
    if (userId != null) {
      context.read<ProfileCubit>().loadProfile(userId);
      _statsCubit.loadStats(userId);
      _streakCubit.watchUserStreak(userId);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _streakCubit.close();
    super.dispose();
  }

  void _showSuccessToast(String message) {
    if (!mounted) return;

    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: Text('Başarılı'),
      description: Text(message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: _streakCubit,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            t.profile.profile,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: theme.colorScheme.surface.withOpacity(0.5),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            const AnimatedBackground(),
            SafeArea(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Loading profile...',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.error!,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final profile = state.profile;
                  if (profile == null) {
                    return Center(
                      child: Text(
                        t.profile.profileNotFound,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    );
                  }

                  return ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.fromLTRB(
                        16, 8, 16, MediaQuery.of(context).padding.bottom + 80),
                    children: [
                      EditableProfileHeader(
                        profile: profile,
                        onDisplayNameChanged: (newName) {
                          context
                              .read<ProfileCubit>()
                              .updateDisplayName(newName, profile.userId);
                          _showSuccessToast('Username updated successfully');
                        },
                      ),
                      const SizedBox(height: 16),
                      const StatsCardWidget(),
                      const SizedBox(height: 16),
                      const SettingsItemWidget(),
                      const SizedBox(height: 32),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
