import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class ProfileNotFound extends StatelessWidget {
  const ProfileNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Text(
        t.profile.profileNotFound,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.error,
        ),
      ),
    );
  }
}
