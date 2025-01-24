import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/auth/application/auth_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_button.dart';
import 'package:dream/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    super.key,
    required this.onSubmit,
  });

  final Function(String email, String password) onSubmit;

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await widget.onSubmit(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _emailController,
              label: t.registration.email.emailText,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return t.registration.email.emailValidation;
                }
                if (!value.contains('@')) {
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
              suffixIcon:
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              onSuffixIconTap: _togglePasswordVisibility,
              obscureText: !_isPasswordVisible,
              autofillHints: const [AutofillHints.newPassword],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return t.registration.password.passwordValidation;
                }
                if (value.length < 6) {
                  return t.registration.password
                      .passwordShort(minPasswordSize: 6);
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _confirmPasswordController,
              label: t.registration.confirmPassword.confirmPasswordText,
              prefixIcon: Icons.lock_outline,
              suffixIcon: _isConfirmPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              onSuffixIconTap: _toggleConfirmPasswordVisibility,
              obscureText: !_isConfirmPasswordVisible,
              validator: (value) {
                if (value != _passwordController.text) {
                  return t.registration.confirmPassword.confirmPasswordMismatch;
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) => AppButton(
                text: t.registration.signUp.signUpText,
                onPressed: state.isLoading ? null : _handleSubmit,
                isLoading: state.isLoading,
                icon: Icons.person_add,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
