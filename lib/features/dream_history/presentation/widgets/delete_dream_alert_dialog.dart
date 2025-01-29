import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:dream/shared/widgets/app_button.dart' as app;

class DeleteDreamAlertDialog extends StatelessWidget {
  const DeleteDreamAlertDialog({
    super.key,
    required this.theme,
    required this.dream,
  });

  final ThemeData theme;
  final DreamHistoryModel dream;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.95),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      title: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_rounded,
              color: theme.colorScheme.error,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            t.searchDreams.delete,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.searchDreams.deleteConfirmation.replaceAll(
                '{title}', dream.title.isEmpty ? 'Untitled' : dream.title),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            t.searchDreams.deleteWarning,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: app.AppButton(
                text: t.common.cancel,
                onPressed: () => Navigator.of(context).pop(false),
                style: app.ButtonStyle.text,
                size: app.ButtonSize.small,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: app.AppButton(
                text: t.searchDreams.delete,
                onPressed: () => Navigator.of(context).pop(true),
                style: app.ButtonStyle.danger,
                size: app.ButtonSize.small,
              ),
            ),
          ],
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
    );
  }
}
