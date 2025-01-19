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

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.dreamEntry.yourDream,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.15),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          widget.dreamEntry.content,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                            height: 1.7,
                            letterSpacing: 0.2,
                            color: theme.colorScheme.onSurface.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        t.dreamEntry.interpretation.interpretationText,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                theme.colorScheme.secondary.withOpacity(0.15),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          widget.dreamEntry.interpretation,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.7,
                            letterSpacing: 0.2,
                            color: theme.colorScheme.onSurface.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      24, 20, 24, bottomPadding + bottomNavBarHeight + 20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        text: t.dreamEntry.saveDream,
                        onPressed: widget.onSave,
                        icon: Icons.save_rounded,
                        height: 52,
                        width: double.infinity,
                        variant: AppButtonVariant.primary,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              text: t.dreamEntry.shareDream,
                              onPressed: _shareDream,
                              icon: Icons.share_rounded,
                              height: 48,
                              variant: AppButtonVariant.ghost,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: AppButton(
                              text: t.dreamEntry.discardDream,
                              onPressed: widget.onDiscard,
                              icon: Icons.delete_outline_rounded,
                              height: 48,
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
      ),
    );
  }
}
