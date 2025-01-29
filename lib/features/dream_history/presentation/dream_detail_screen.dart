import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/config/theme/theme_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/core/presentation/animated_background.dart';
import 'package:dream/shared/widgets/mood_rating_widget.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:dream/shared/utils/share_utils.dart';

class DreamDetailScreen extends StatefulWidget {
  final DreamHistoryModel dream;

  const DreamDetailScreen({super.key, required this.dream});

  @override
  State<DreamDetailScreen> createState() => _DreamDetailScreenState();
}

class _DreamDetailScreenState extends State<DreamDetailScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              const AnimatedBackground(),
              // Main content
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDarkMode
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onPrimary,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    title: Text(
                      widget.dream.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: isDarkMode
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      BlocBuilder<DreamHistoryCubit, DreamHistoryState>(
                        builder: (context, state) {
                          final dream = state.dreams.firstWhere(
                            (d) => d.id == widget.dream.id,
                            orElse: () => widget.dream,
                          );
                          return Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  dream.isFavourite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: dream.isFavourite
                                      ? Colors.red
                                      : (isDarkMode
                                          ? theme.colorScheme.onSurface
                                          : theme.colorScheme.onPrimary),
                                ),
                                onPressed: () {
                                  context
                                      .read<DreamHistoryCubit>()
                                      .toggleFavorite(dream);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.share_outlined,
                                  color: isDarkMode
                                      ? theme.colorScheme.onSurface
                                      : theme.colorScheme.onPrimary,
                                ),
                                onPressed: () => ShareUtils.shareDreamAsImage(
                                  context: context,
                                  title: widget.dream.title,
                                  content: widget.dream.content,
                                  interpretation: widget.dream.interpretation,
                                  date: widget.dream.createdAt,
                                  moodRating: widget.dream.moodRating,
                                  profile: context
                                      .read<ProfileCubit>()
                                      .state
                                      .profile,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: isDarkMode
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.error
                                          .withValues(alpha: 0.9),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor:
                                          theme.colorScheme.surface,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      title: Text(
                                        'Delete Dream',
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          color: theme.colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete this dream? This action cannot be undone.',
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: theme.colorScheme.onSurface
                                              .withValues(alpha: 0.8),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => context.pop(),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<DreamHistoryCubit>()
                                                .deleteDream(dream.id);
                                            context.pop(); // Close dialog
                                            context
                                                .pop(); // Go back to dream history
                                          },
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: theme.colorScheme.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                    expandedHeight: 200,
                    toolbarHeight: 54,
                    collapsedHeight: 54,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: FlexibleSpaceBar(
                          titlePadding: EdgeInsets.only(
                            left: 56,
                            right: 16,
                            bottom: 16,
                          ),
                          centerTitle: false,
                          expandedTitleScale: 1.3,
                          background: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: isDarkMode
                                    ? [
                                        theme.colorScheme.primary
                                            .withValues(alpha: 0.3),
                                        theme.colorScheme.secondary
                                            .withValues(alpha: 0.15),
                                      ]
                                    : [
                                        theme.colorScheme.primary
                                            .withValues(alpha: 0.8),
                                        theme.colorScheme.secondary
                                            .withValues(alpha: 0.4),
                                      ],
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.auto_awesome,
                                size: 64,
                                color: (isDarkMode
                                        ? theme.colorScheme.onSurface
                                        : theme.colorScheme.onPrimary)
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSection(
                            context,
                            title: t.dreamEntry.yourDream,
                            content: widget.dream.content,
                            icon: Icons.nights_stay_outlined,
                          ),
                          const SizedBox(height: 20),
                          if (widget.dream.interpretation.isNotEmpty)
                            _buildSection(
                              context,
                              title: t.dreamEntry.interpretation.title,
                              content: widget.dream.interpretation,
                              icon: Icons.psychology,
                              iconColor: theme.colorScheme.tertiary,
                            ),
                          const SizedBox(height: 20),
                          _buildMoodRatingSection(context),
                          const SizedBox(height: 20),
                          if (widget.dream.tags.isNotEmpty)
                            _buildTagsSection(context, widget.dream.tags),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    IconData? icon,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: (isDarkMode
                    ? theme.colorScheme.surface
                    : theme.colorScheme.surface)
                .withValues(alpha: isDarkMode ? 0.4 : 0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: (isDarkMode
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary)
                  .withValues(alpha: isDarkMode ? 0.3 : 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary
                    .withValues(alpha: isDarkMode ? 0.2 : 0.1),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (iconColor ?? theme.colorScheme.primary)
                            .withValues(alpha: isDarkMode ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ?? theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagsSection(BuildContext context, List<String> tags) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary
                      .withValues(alpha: isDarkMode ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.local_offer_outlined,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                t.dreamEntry.tags.tags,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) {
              return Container(
                decoration: BoxDecoration(
                  color: (isDarkMode
                          ? theme.colorScheme.secondaryContainer
                          : theme.colorScheme.secondaryContainer)
                      .withValues(alpha: isDarkMode ? 0.5 : 0.7),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.secondary
                          .withValues(alpha: isDarkMode ? 0.2 : 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        tag,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: isDarkMode
                              ? theme.colorScheme.onSecondaryContainer
                                  .withValues(alpha: 0.9)
                              : theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodRatingSection(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.surface
                      .withValues(alpha: isDarkMode ? 0.7 : 0.8),
                  theme.colorScheme.surface
                      .withValues(alpha: isDarkMode ? 0.5 : 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.colorScheme.primary
                    .withValues(alpha: isDarkMode ? 0.3 : 0.2),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary
                            .withValues(alpha: isDarkMode ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.mood,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Mood Rating',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: MoodRatingWidget(
                    rating: widget.dream.moodRating,
                    isInteractive: false,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
