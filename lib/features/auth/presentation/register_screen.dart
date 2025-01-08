import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/features/auth/application/auth_state.dart';
import 'package:go_router/go_router.dart';

/// Screen that handles user registration functionality.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await context.read<AuthCubit>().register(
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
    return Scaffold(
      appBar: AppBar(
        title: Text(t.registration.signUp.signUpText), // Replaced text
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
                    t.registration.signUp.signUpCaption,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText:
                          t.registration.email.emailText, // Replaced text
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.registration.email
                            .emailValidation; // Replaced text
                      }
                      if (!value.contains('@')) {
                        return t
                            .registration.email.emailInvalid; // Replaced text
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText:
                          t.registration.password.passwordText, // Replaced text
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.registration.password
                            .passwordValidation; // Replaced text
                      }
                      if (value.length < 6) {
                        return t.registration.password
                            .passwordShort(minPasswordSize: 6); // Replaced text
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: t.registration.confirmPassword
                          .confirmPasswordText, // Replaced text
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isConfirmPasswordVisible,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return t.registration.confirmPassword
                            .confirmPasswordMismatch; // Replaced text
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: state.isLoading ? null : _handleRegister,
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            t.registration.signUp.signUpText), // Replaced text
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(t.registration.signUp
                        .alreadyHaveAccount), // Replaced text
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
