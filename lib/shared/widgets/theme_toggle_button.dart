import 'package:dream/config/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that displays a toggle button for switching between light and dark themes
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.brightness_6),
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
