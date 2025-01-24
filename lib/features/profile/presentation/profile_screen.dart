import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/features/profile/application/stats_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/stats_card_widget.dart';
import '../widgets/settings_item_widget.dart';
import 'dart:ui';
import 'package:dream/core/presentation/animated_background.dart';
import 'package:dream/features/profile/application/streak_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/core/di/injection.dart';

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
    _streakCubit = getIt<StreakCubit>();

    final userId = context.read<AuthCubit>().state.user?.id;
    if (userId != null) {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _streakCubit,
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatelessWidget {
  const _ProfileScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const _ProfileAppBar(),
      body: Stack(
        children: const [
          AnimatedBackground(),
          _ProfileBody(),
        ],
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProfileAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () => context.push(AppRoute.settings),
        ),
      ],
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: theme.colorScheme.surface.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const _LoadingIndicator();
          }

          if (state.error != null) {
            return _ErrorDisplay(error: state.error!);
          }

          final profile = state.profile;
          if (profile == null) {
            return const _ProfileNotFound();
          }

          return _ProfileContent(profile: profile);
        },
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
            16, 8, 16, MediaQuery.of(context).padding.bottom + 80),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Skeleton.ignore(
                      child: SvgPicture.asset('assets/avatars/avatar1.svg'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'displayName',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('email'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const StatsCardWidget(),
          const SizedBox(height: 16),
          const SettingsItemWidget(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ErrorDisplay extends StatelessWidget {
  const _ErrorDisplay({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            error,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileNotFound extends StatelessWidget {
  const _ProfileNotFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Text(
        t.profile.profileNotFound,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.error,
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.profile});

  final dynamic profile;

  String _getTranslatedGender(String gender) {
    final genderMap = {
      'male': t.profile.personalization.genderOptions.male,
      'female': t.profile.personalization.genderOptions.female,
      'other': t.profile.personalization.genderOptions.other,
      'preferNotToSay': t.profile.personalization.genderOptions.preferNotToSay,
    };
    return genderMap[gender] ?? gender;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView(
      padding: EdgeInsets.fromLTRB(
          16, 8, 16, MediaQuery.of(context).padding.bottom + 80),
      children: [
        EditableProfileHeader(
          profile: profile,
          onDisplayNameChanged: (newName) {
            context.read<ProfileCubit>().updateDisplayName(newName);
            _showSuccessToast(context, 'Username updated successfully');
          },
        ),
        const SizedBox(height: 16),
        const StatsCardWidget(),
        const SizedBox(height: 16),
        if (profile.gender != null ||
            profile.horoscope != null ||
            profile.occupation != null ||
            profile.relationshipStatus != null ||
            profile.birthDate != null ||
            (profile.interests?.isNotEmpty ?? false))
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.profile.personalization.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () {
                          context.push(AppRoute.personalization);
                        },
                        visualDensity: VisualDensity.compact,
                        style: IconButton.styleFrom(
                          backgroundColor:
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        if (profile.gender != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.gender,
                            _getTranslatedGender(profile.gender!),
                            Icons.person,
                            showDivider: profile.birthDate != null ||
                                profile.horoscope != null ||
                                profile.occupation != null ||
                                profile.relationshipStatus != null,
                          ),
                        if (profile.birthDate != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.birthDate,
                            DateFormat('dd/MM/yyyy').format(profile.birthDate),
                            Icons.calendar_today,
                            showDivider: profile.horoscope != null ||
                                profile.occupation != null ||
                                profile.relationshipStatus != null,
                          ),
                        if (profile.horoscope != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.horoscope,
                            profile.horoscope,
                            Icons.auto_awesome,
                            showDivider: profile.occupation != null ||
                                profile.relationshipStatus != null,
                          ),
                        if (profile.occupation != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.occupation,
                            profile.occupation,
                            Icons.work,
                            showDivider: profile.relationshipStatus != null,
                          ),
                        if (profile.relationshipStatus != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.relationshipStatus,
                            profile.relationshipStatus,
                            Icons.favorite,
                            showDivider: false,
                          ),
                      ],
                    ),
                  ),
                  if (profile.interests?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 16),
                    Text(
                      t.profile.personalization.interests,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              theme.colorScheme.outline.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final interest in profile.interests!)
                            Chip(
                              label: Text(
                                interest,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              backgroundColor: colorScheme.surface,
                              side: BorderSide(
                                color: theme.colorScheme.outline
                                    .withValues(alpha: 0.2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    bool showDivider = true,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    Text(
                      value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
      ],
    );
  }

  void _showSuccessToast(BuildContext context, String message) {
    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: const Text('Başarılı'),
      description: Text(message),
    );
  }
}
