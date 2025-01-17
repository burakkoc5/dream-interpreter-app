import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/dream_entry_model.dart';
import 'package:dream/shared/widgets/app_button.dart';
import 'package:share_plus/share_plus.dart';

class InterpretationModalContent extends StatefulWidget {
  final DreamEntry dreamEntry;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onDiscard;

  const InterpretationModalContent({
    super.key,
    required this.dreamEntry,
    required this.onSave,
    required this.onShare,
    required this.onDiscard,
  });

  @override
  State<InterpretationModalContent> createState() =>
      _InterpretationModalContentState();
}

class _InterpretationModalContentState
    extends State<InterpretationModalContent> {
  Future<void> _shareDream() async {
    final shareText = '''
✨ Dream Journal Entry ✨
━━━━━━━━━━━━━━━━━━━━━━

🌙 My Dream:
${widget.dreamEntry.content}

🔮 Interpretation:
${widget.dreamEntry.interpretation}

━━━━━━━━━━━━━━━━━━━━━━
📱 Shared from Dream Journal App
''';

    await Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final bottomNavBarHeight =
        MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.dreamEntry.yourDream,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          widget.dreamEntry.content,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        t.dreamEntry.interpretation.interpretationText,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.secondary.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          widget.dreamEntry.interpretation,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    24, 16, 24, bottomPadding + bottomNavBarHeight + 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(
                      text: t.dreamEntry.saveDream,
                      onPressed: widget.onSave,
                      icon: Icons.save_rounded,
                      height: 44,
                      width: double.infinity,
                      variant: AppButtonVariant.primary,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: t.dreamEntry.shareDream,
                            onPressed: _shareDream,
                            icon: Icons.share_rounded,
                            height: 44,
                            variant: AppButtonVariant.ghost,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            text: t.dreamEntry.discardDream,
                            onPressed: widget.onDiscard,
                            icon: Icons.delete_outline_rounded,
                            height: 44,
                            variant: AppButtonVariant.ghost,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
