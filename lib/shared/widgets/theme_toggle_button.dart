import 'package:dream/config/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that displays a toggle button for switching between light and dark themes
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(isDarkMode ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.brightness_6,
          color: theme.colorScheme.primary,
        ),
      ),
      title: const Text('Dark Mode'),
      trailing: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return Switch(
            value: isDarkMode,
            onChanged: (_) {
              context.read<ThemeCubit>().toggleTheme();
            },
          );
        },
      ),
    );
  }
}
