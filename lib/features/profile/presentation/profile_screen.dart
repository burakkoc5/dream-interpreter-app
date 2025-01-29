import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/features/profile/application/stats_cubit.dart';
import 'package:dream/features/profile/presentation/widgets/error_display.dart';
import 'package:dream/features/profile/presentation/widgets/loading_indicator.dart';
import 'package:dream/features/profile/presentation/widgets/profile_content.dart';
import 'package:dream/features/profile/presentation/widgets/profile_not_found.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:dream/core/presentation/animated_background.dart';
import 'package:dream/features/profile/application/streak_cubit.dart';
import 'package:go_router/go_router.dart';
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
            return LoadingIndicator();
          }

          if (state.error != null) {
            return ErrorDisplay(error: state.error!);
          }

          final profile = state.profile;
          if (profile == null) {
            return ProfileNotFound();
          }

          return ProfileContent(profile: profile);
        },
      ),
    );
  }
}
