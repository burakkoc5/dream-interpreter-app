import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteGuard {
  static String? guard(BuildContext context, GoRouterState state) {
    final isAuthenticated = context.read<AuthCubit>().state.isAuthenticated;
    null; // Correctly reflects authentication
    final location = state.uri.toString();

    print('RouteGuard - isAuthenticated: $isAuthenticated');
    print('RouteGuard - location: $location');

    if (!isAuthenticated && !location.startsWith(AppRoute.root)) {
      print('Redirecting to root');
      return AppRoute.login;
    }

    if (isAuthenticated && location == AppRoute.root) {
      print('Redirecting to dream entry');
      return AppRoute.dreamEntry;
    }

    // Redirect root /home to /home/dreams
    if (isAuthenticated && location == '/home') {
      return AppRoute.dreamEntry;
    }

    return null;
  }
}
