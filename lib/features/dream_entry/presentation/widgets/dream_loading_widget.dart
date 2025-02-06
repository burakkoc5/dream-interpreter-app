import 'package:flutter/material.dart';
import 'package:dream/i18n/strings.g.dart';
import 'dart:math' as math;

class DreamLoadingWidget extends StatefulWidget {
  const DreamLoadingWidget({super.key});

  @override
  State<DreamLoadingWidget> createState() => _DreamLoadingWidgetState();
}

class _DreamLoadingWidgetState extends State<DreamLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 32),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: colorScheme.surface.withOpacity(0.1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Outer rotating circle
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * math.pi,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              colorScheme.primary.withOpacity(0.1),
                              colorScheme.primary.withOpacity(0.3),
                              colorScheme.secondary.withOpacity(0.3),
                              colorScheme.secondary.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Middle rotating circle (opposite direction)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: -_controller.value * 2 * math.pi,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              colorScheme.secondary.withOpacity(0.1),
                              colorScheme.secondary.withOpacity(0.2),
                              colorScheme.primary.withOpacity(0.2),
                              colorScheme.primary.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Center circle with progress indicator
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surface.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              t.dreamEntry.interpretation.title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: 0.4 + (_controller.value * 0.6),
                  child: Text(
                    t.common.loading,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
