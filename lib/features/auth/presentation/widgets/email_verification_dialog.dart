import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_button.dart' as app_button;
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
                isSignIn
                    ? t.core.emailVerificationDialog.notVerifiedTitle
                    : t.core.emailVerificationDialog.verifyTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                isSignIn
                    ? t.core.emailVerificationDialog.notVerifiedMessage
                    : t.core.emailVerificationDialog
                        .verifyMessage(email: email),
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
                      ? t.core.emailVerificationDialog.needVerification
                      : t.core.emailVerificationDialog.checkInbox,
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
                      child: app_button.AppButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: t.core.emailVerificationDialog.cancel,
                        style: app_button.ButtonStyle.outlined,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: app_button.AppButton(
                        onPressed: onResendEmail,
                        text: t.core.emailVerificationDialog.resend,
                      ),
                    ),
                  ],
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: app_button.AppButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(AppRoute.login);
                    },
                    text: t.core.emailVerificationDialog.goToLogin,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
