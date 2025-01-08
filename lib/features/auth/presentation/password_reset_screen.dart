import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/features/auth/application/auth_state.dart';

import 'package:go_router/go_router.dart';

/// Screen that handles password reset functionality.
class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await context.read<AuthCubit>().resetPassword(
              _emailController.text.trim(),
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  t.registration.password.resetPassword.resetPasswordCaption),
            ),
          );
          context.pop();
        }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(t.registration.password.resetPassword.resetPasswordText),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.registration.signIn.forgotPassword,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.registration.password.resetPassword.resetPasswordCaption,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: t.registration.email.emailText,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
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
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: state.isLoading ? null : _handlePasswordReset,
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(t.registration.password.resetPassword
                            .resetPasswordButton),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                        t.registration.password.resetPassword.backToSignIn),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
