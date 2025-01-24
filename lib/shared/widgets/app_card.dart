import 'package:flutter/material.dart';
import 'dart:ui';

/// A customizable card widget that follows the app's ethereal theme guidelines.
class AppCard extends StatefulWidget {
  /// Creates an AppCard with required child widget.
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(8),
    this.elevation,
    this.isGlassmorphic = true,
    this.borderRadius,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double? elevation;
  final bool isGlassmorphic;
  final double? borderRadius;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovered) {
    if (widget.onTap != null) {
      setState(() => _isHovered = isHovered);
      if (isHovered) {
        _hoverController.forward();
      } else {
        _hoverController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = widget.borderRadius ?? 24.0;

    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: widget.margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                boxShadow: [
                  // Ambient shadow
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                  // Glow effect
                  if (_isHovered)
                    BoxShadow(
                      color: theme.colorScheme.primary
                          .withValues(alpha: 0.2 * _glowAnimation.value),
                      blurRadius: 16,
                      spreadRadius: 4 * _glowAnimation.value,
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.isGlassmorphic ? 8 : 0,
                    sigmaY: widget.isGlassmorphic ? 8 : 0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.cardTheme.color?.withValues(
                                  alpha: widget.isGlassmorphic ? 0.7 : 0.95) ??
                              Colors.white.withValues(
                                  alpha: widget.isGlassmorphic ? 0.7 : 0.95),
                          theme.cardTheme.color?.withValues(
                                  alpha: widget.isGlassmorphic ? 0.5 : 0.85) ??
                              Colors.white.withValues(
                                  alpha: widget.isGlassmorphic ? 0.5 : 0.85),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                      border: Border.all(
                        color: theme.colorScheme.primary
                            .withValues(alpha: _isHovered ? 0.2 : 0.1),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onTap,
                        borderRadius: BorderRadius.circular(radius),
                        splashColor:
                            theme.colorScheme.primary.withValues(alpha: 0.1),
                        highlightColor:
                            theme.colorScheme.primary.withValues(alpha: 0.05),
                        child: Padding(
                          padding: widget.padding,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
