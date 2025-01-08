import 'package:dream/features/profile/application/stats_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/stats_cubit.dart';

class StatsCardWidget extends StatelessWidget {
  const StatsCardWidget({super.key});

  String _formatNumber(dynamic value) {
    if (value == null) return '0';
    if (value is int) return value.toString();
    if (value is double) return (value * 100).round().toString();
    return '0';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsCubit, StatsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Card(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final stats = state.stats;

        return Card(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    t.profile.dreamStats,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        context,
                        _formatNumber(stats['totalDreams']),
                        t.profile.totalDreams,
                      ),
                      _buildStatItem(
                        context,
                        _formatNumber(stats['weeklyDreams']),
                        t.profile.weeklyDreams,
                      ),
                      _buildStatItem(
                        context,
                        '${_formatNumber(stats['completionRate'])}%',
                        t.profile.completionRate,
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
