import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/auth/application/auth_state.dart';
import 'package:dream/features/dream_entry/presentation/dream_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isAuthenticated) {
          return const DreamEntryScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
