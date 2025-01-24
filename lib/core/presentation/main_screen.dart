import 'package:flutter/material.dart';
import 'package:dream/config/theme/theme_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:go_router/go_router.dart';
import 'widgets/nav_item_widget.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({
    super.key,
    required this.child,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int get _selectedIndex {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoute.dreamHistory)) return 0;
    if (location.startsWith(AppRoute.dreamEntry)) return 1;
    if (location.startsWith(AppRoute.profile)) return 2;
    return 0;
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go(AppRoute.dreamHistory);
        break;
      case 1:
        context.go(AppRoute.dreamEntry);
        break;
      case 2:
        context.go(AppRoute.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          widget.child,
          if (!keyboardVisible)
            Positioned(
              left: 8,
              right: 8,
              bottom: 0,
              child: SafeArea(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      height: 72,
                      decoration: BoxDecoration(
                        color: (isDarkMode
                                ? theme.colorScheme.surface
                                : theme.colorScheme.surface)
                            .withValues(alpha: isDarkMode ? 0.5 : 0.7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NavItemWidget(
                            icon: Icons.auto_awesome_outlined,
                            selectedIcon: Icons.auto_awesome,
                            label: t.dreamHistory.dreamHistory,
                            isSelected: _selectedIndex == 0,
                            onTap: () => _onItemTapped(0),
                          ),
                          NavItemWidget(
                            icon: Icons.add_circle_outline,
                            selectedIcon: Icons.add_circle,
                            label: t.dreamEntry.newDream,
                            isSelected: _selectedIndex == 1,
                            onTap: () => _onItemTapped(1),
                          ),
                          NavItemWidget(
                            icon: Icons.person_outline,
                            selectedIcon: Icons.person,
                            label: t.profile.profile,
                            isSelected: _selectedIndex == 2,
                            onTap: () => _onItemTapped(2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
