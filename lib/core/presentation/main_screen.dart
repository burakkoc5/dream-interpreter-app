import 'package:dream/core/routing/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
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
        },
        selectedIndex: _calculateSelectedIndex(context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'New Dream',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location =
        GoRouterState.of(context).uri.path; // Updated to use GoRouter.of
    if (location.startsWith(AppRoute.dreamHistory)) return 0;
    if (location.startsWith(AppRoute.dreamEntry)) return 1;
    if (location.startsWith(AppRoute.profile)) return 2;
    return 0; // Default to the first tab.
  }
}
