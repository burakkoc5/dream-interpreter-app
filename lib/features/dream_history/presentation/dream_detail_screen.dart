import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/config/theme/theme_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/core/presentation/animated_background.dart';

class DreamDetailScreen extends StatefulWidget {
  final DreamHistoryModel dream;

  const DreamDetailScreen({super.key, required this.dream});

  @override
  State<DreamDetailScreen> createState() => _DreamDetailScreenState();
}

class _DreamDetailScreenState extends State<DreamDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Animated gradient background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(
                      math.cos(_controller.value * 2 * math.pi),
                      math.sin(_controller.value * 2 * math.pi),
                    ),
                    end: Alignment(
                      -math.sin(_controller.value * 2 * math.pi),
                      math.cos(_controller.value * 2 * math.pi),
                    ),
                    colors: isDarkMode
                        ? [
                            theme.colorScheme.surface,
                            theme.colorScheme.surface.withOpacity(0.9),
                            theme.colorScheme.primary.withOpacity(0.15),
                            theme.colorScheme.secondary.withOpacity(0.15),
                          ]
                        : [
                            theme.colorScheme.background,
                            theme.colorScheme.background,
                            theme.colorScheme.background.withOpacity(0.95),
                            theme.colorScheme.background.withOpacity(0.9),
                          ],
                  ),
                ),
              );
            },
          ),
          // Animated stars background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: StarfieldPainter(
                  color: isDarkMode ? Colors.white : theme.colorScheme.primary,
                  animation: _controller.value,
                  starCount: 200,
                  opacity: isDarkMode ? 0.5 : 0.3,
                ),
                size: Size.infinite,
              );
            },
          ),
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
                actions: [
                  IconButton(
                    icon: Icon(
                      widget.dream.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.dream.isFavourite
                          ? Colors.red
                          : (isDarkMode
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onPrimary),
                    ),
                    onPressed: () {
                      context
                          .read<DreamHistoryCubit>()
                          .toggleFavorite(widget.dream);
                    },
                  ),
                ],
                expandedHeight: 200,
                toolbarHeight: 72,
                collapsedHeight: 72,
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
                      title: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Text(
                          widget.dream.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: isDarkMode
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            shadows: [
                              Shadow(
                                color: (isDarkMode
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.onPrimary)
                                    .withOpacity(0.5),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: isDarkMode
                                ? [
                                    theme.colorScheme.primary.withOpacity(0.3),
                                    theme.colorScheme.secondary
                                        .withOpacity(0.15),
                                  ]
                                : [
                                    theme.colorScheme.primary.withOpacity(0.4),
                                    theme.colorScheme.secondary
                                        .withOpacity(0.2),
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
                                .withOpacity(0.3),
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
                        title: t.dreamDetail,
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
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    IconData? icon,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state;

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
              color: (isDarkMode
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary)
                  .withOpacity(isDarkMode ? 0.3 : 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary
                    .withOpacity(isDarkMode ? 0.2 : 0.1),
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
                            .withOpacity(isDarkMode ? 0.2 : 0.1),
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
                  color: theme.colorScheme.onSurface.withOpacity(0.9),
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
    final isDarkMode = context.watch<ThemeCubit>().state;

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
                      .withOpacity(isDarkMode ? 0.2 : 0.1),
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
                      .withOpacity(isDarkMode ? 0.5 : 0.7),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.secondary
                          .withOpacity(isDarkMode ? 0.2 : 0.1),
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
                                  .withOpacity(0.9)
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
    final isDarkMode = context.watch<ThemeCubit>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color:
                  theme.colorScheme.surface.withOpacity(isDarkMode ? 0.4 : 0.7),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.colorScheme.primary
                    .withOpacity(isDarkMode ? 0.3 : 0.2),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary
                        .withOpacity(isDarkMode ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.mood,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mood Rating',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < widget.dream.moodRating
                              ? Icons.star
                              : Icons.star_border,
                          color: theme.colorScheme.primary,
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
