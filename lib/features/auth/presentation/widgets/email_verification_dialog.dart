import 'package:dream/core/routing/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationDialog extends StatelessWidget {
  final String email;
  final bool isSignIn;
  final Function()? onResendEmail;

  const EmailVerificationDialog({
    super.key,
    required this.email,
    this.isSignIn = false,
    this.onResendEmail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mark_email_read_outlined,
                color: isSignIn
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
                size: 32,
              ),
              const SizedBox(height: 16),
              Text(
                isSignIn ? 'Email Not Verified' : 'Verify Your Email',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                isSignIn
                    ? 'Please verify your email before signing in. Check your inbox for the verification link.'
                    : 'A verification email has been sent to $email. Please verify your email to continue.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isSignIn
                          ? theme.colorScheme.error
                          : theme.colorScheme.primary)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isSignIn
                      ? 'Need a new verification email?'
                      : 'Check your inbox and spam folder for the verification link.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isSignIn
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              if (isSignIn)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: onResendEmail,
                        child: const Text('Resend'),
                      ),
                    ),
                  ],
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(AppRoute.login);
                    },
                    child: const Text('Go to Login'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
