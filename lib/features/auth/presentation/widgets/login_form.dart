import 'dart:async';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/auth/application/auth_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_button.dart' as app;
import 'package:dream/shared/widgets/app_text_field.dart';
import 'package:dream/shared/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _lastError;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {});
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      _lastError = null;
      await context.read<AuthCubit>().signIn(
            _emailController.text.trim(),
            _passwordController.text,
            context,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Form(
        key: _formKey,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state.error != null && state.error != _lastError) {
              _lastError = state.error;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppToast.showError(
                  context,
                  title: t.core.errors.error,
                  description: state.error!,
                );
              });
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'app_logo',
                  child: Image.asset(
                    'assets/images/logo_nbg.png',
                    height: 120,
                    width: 120,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  t.registration.welcomeText,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  t.registration.signIn.subtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _emailController,
                  label: t.registration.email.emailText,
                  prefix: Icon(Icons.email_outlined),
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
                  prefix: Icon(Icons.lock_outline),
                  suffix: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: _togglePasswordVisibility,
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return t.registration.password.passwordValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                app.AppButton(
                  text: t.registration.signIn.signInText,
                  onPressed: _handleLogin,
                  isLoading: state.isLoading,
                  icon: Icons.login,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        t.registration.signIn.or,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                app.AppButton(
                  text: t.registration.signUp.signUpText,
                  onPressed: () {
                    _clearForm();
                    context.push(AppRoute.register);
                  },
                  style: app.ButtonStyle.text,
                  icon: Icons.person_add_outlined,
                ),
                app.AppButton(
                  onPressed: () {
                    _clearForm();
                    context.push(AppRoute.passwordReset);
                  },
                  text: t.registration.signIn.forgotPassword,
                  style: app.ButtonStyle.text,
                  icon: Icons.lock_outline,
                ),
              ],
            );
          },
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
