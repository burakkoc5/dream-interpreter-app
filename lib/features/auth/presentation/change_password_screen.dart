import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/auth/application/auth_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await context.read<AuthCubit>().changePassword(
            currentPassword: _currentPasswordController.text,
            newPassword: _newPasswordController.text,
          );
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(t.registration.password.changePassword.success)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(t.registration.password.changePassword.changePasswordText)),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _currentPasswordController,
                  decoration: InputDecoration(
                    labelText:
                        t.registration.password.changePassword.currentPassword,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return t.registration.password.changePassword
                          .currentPasswordValidator;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText:
                        t.registration.password.changePassword.newPassword,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return t.registration.password.changePassword
                          .newPasswordValidator;
                    }
                    if (value!.length < 6) {
                      return t.registration.password
                          .passwordShort(minPasswordSize: 6);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: t.registration.password.changePassword
                        .confirmNewPassword,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return t.registration.password.changePassword
                          .newPasswordValidator;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: state.isLoading ? null : _changePassword,
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : Text(t.registration.password.changePassword
                          .changePasswordText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
