import 'package:dream/config/language/language_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  String _getLanguageName(AppLocale locale) {
    switch (locale) {
      case AppLocale.en:
        return 'English';
      case AppLocale.de:
        return 'Deutsch';
      case AppLocale.tr:
        return 'Türkçe';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LanguageCubit, AppLocale>(
      builder: (context, currentLocale) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          minVerticalPadding: 0,
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.language,
              color: theme.colorScheme.primary,
              size: 18,
            ),
          ),
          title: Text(
            t.profile.language,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          trailing: DropdownButton<AppLocale>(
            value: currentLocale,
            icon: Icon(
              Icons.arrow_drop_down,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              size: 18,
            ),
            elevation: 2,
            underline: const SizedBox(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 14,
            ),
            items: AppLocale.values.map((locale) {
              return DropdownMenuItem(
                value: locale,
                child: Text(
                  _getLanguageName(locale),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
            onChanged: (AppLocale? newLocale) {
              if (newLocale != null) {
                context.read<LanguageCubit>().setLanguage(newLocale);
              }
            },
          ),
        );
      },
    );
  }
}
