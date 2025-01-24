import 'package:dream/config/theme/theme_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that displays a toggle button for switching between system, light and dark themes
class ThemeToggleButton extends StatelessWidget {
  final bool showLabel;
  final bool isCompact;

  const ThemeToggleButton({
    super.key,
    this.showLabel = true,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeCubit = context.watch<ThemeCubit>();
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = themeCubit.state == ThemeMode.dark ||
        (themeCubit.state == ThemeMode.system && brightness == Brightness.dark);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: PopupMenuButton<ThemeMode>(
        initialValue: themeCubit.state,
        onSelected: (ThemeMode mode) {
          themeCubit.setTheme(mode);
        },
        child: isCompact
            ? Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Icon(
                  themeCubit.state == ThemeMode.system
                      ? Icons.brightness_auto
                      : themeCubit.state == ThemeMode.light
                          ? Icons.light_mode
                          : Icons.dark_mode,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
              )
            : ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                minVerticalPadding: 0,
                leading: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary
                        .withValues(alpha: isDarkMode ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    themeCubit.state == ThemeMode.system
                        ? Icons.brightness_auto
                        : themeCubit.state == ThemeMode.light
                            ? Icons.light_mode
                            : Icons.dark_mode,
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                ),
                title: Text(
                  themeCubit.state == ThemeMode.system
                      ? 'System'
                      : themeCubit.state == ThemeMode.light
                          ? t.core.mode.lightMode
                          : t.core.mode.darkMode,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
              ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
          PopupMenuItem<ThemeMode>(
            value: ThemeMode.system,
            child: Row(
              children: [
                Icon(
                  Icons.brightness_auto,
                  size: 18,
                  color: themeCubit.state == ThemeMode.system
                      ? theme.colorScheme.primary
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  'System',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<ThemeMode>(
            value: ThemeMode.light,
            child: Row(
              children: [
                Icon(
                  Icons.light_mode,
                  size: 18,
                  color: themeCubit.state == ThemeMode.light
                      ? theme.colorScheme.primary
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  t.core.mode.lightMode,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<ThemeMode>(
            value: ThemeMode.dark,
            child: Row(
              children: [
                Icon(
                  Icons.dark_mode,
                  size: 18,
                  color: themeCubit.state == ThemeMode.dark
                      ? theme.colorScheme.primary
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  t.core.mode.darkMode,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
