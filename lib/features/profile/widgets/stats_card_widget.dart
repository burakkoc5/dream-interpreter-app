import 'package:dream/config/theme/theme_cubit.dart';
import 'package:dream/features/profile/application/stats_cubit.dart';
import 'package:dream/features/profile/application/stats_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsCardWidget extends StatelessWidget {
  const StatsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeCubit = context.watch<ThemeCubit>();
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = themeCubit.state == ThemeMode.dark ||
        (themeCubit.state == ThemeMode.system && brightness == Brightness.dark);

    return BlocBuilder<StatsCubit, StatsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return _buildContainer(
            theme,
            isDarkMode,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.error != null) {
          return _buildContainer(
            theme,
            isDarkMode,
            child: Center(
              child: Text(state.error!),
            ),
          );
        }

        final stats = state.stats;
        return _buildContainer(
          theme,
          isDarkMode,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.local_fire_department,
                      stats['currentStreak']?.toString() ?? '0',
                      t.profile.currentStreak,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.emoji_events,
                      stats['longestStreak']?.toString() ?? '0',
                      t.profile.longestStreak,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.auto_stories,
                      stats['totalDreams']?.toString() ?? '0',
                      t.profile.totalDreams,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.calendar_today,
                      stats['weeklyDreams']?.toString() ?? '0',
                      t.profile.weeklyDreams,
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

  Widget _buildContainer(ThemeData theme, bool isDarkMode,
      {required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface.withOpacity(isDarkMode ? 0.4 : 0.9),
            theme.colorScheme.surface.withOpacity(isDarkMode ? 0.2 : 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
