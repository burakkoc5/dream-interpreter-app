import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/auth/application/auth_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_button.dart';
import 'package:dream/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await context.read<AuthCubit>().signIn(
              _emailController.text.trim(),
              _passwordController.text,
              context,
            );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.registration.welcomeText,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                AppTextField(
                  controller: _emailController,
                  label: t.registration.email.emailText,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return t.registration.email.emailValidation;
                    }
                    if (!value!.contains('@')) {
                      return t.registration.email.emailInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  label: t.registration.password.passwordText,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: _isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return t.registration.password.passwordValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) => AppButton(
                    text: t.registration.signIn.signInText,
                    onPressed: _handleLogin,
                    isLoading: state.isLoading,
                    icon: Icons.login,
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  text: t.registration.signUp.signUpText,
                  onPressed: () => context.push(AppRoute.register),
                  variant: AppButtonVariant.ghost,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.push(AppRoute.passwordReset),
                  child: Text(
                    t.registration.signIn.forgotPassword,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
