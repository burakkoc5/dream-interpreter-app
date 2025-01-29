import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';

class DreamErrorWidget extends StatelessWidget {
  final String message;

  const DreamErrorWidget({
    super.key,
    required this.message,
  });

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
            '${t.core.errors.error}$message',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.error.withValues(alpha: 0.1),
            ),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: theme.colorScheme.error,
              ),
              onPressed: () {
                context.read<DreamEntryCubit>().reset();
              },
            ),
          ),
        ],
      ),
    );
  }
}
