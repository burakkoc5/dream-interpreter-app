import 'package:dream/core/presentation/animated_background.dart';
import 'package:dream/features/auth/presentation/widgets/login_form.dart';
import 'package:dream/shared/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const ThemeToggleButton(
                      showLabel: false,
                      isCompact: true,
                    ),
                    const SizedBox(height: 24),
                    const LoginForm(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
