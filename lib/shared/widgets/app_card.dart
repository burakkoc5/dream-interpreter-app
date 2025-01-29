import 'package:flutter/material.dart';
import 'dart:ui';

/// A customizable card widget that follows the app's design system.
///
/// This card provides a beautiful glassmorphic effect with hover animations
/// and customizable styling options. It's perfect for creating modern,
/// interactive card layouts.
///
/// Example usage:
/// ```dart
/// AppCard(
///   onTap: () => handleTap(),
///   isGlassmorphic: true,
///   child: Text('Hello World'),
/// )
/// ```
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
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.hoverScale = 1.02,
    this.hoverElevation,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOutCubic,
    this.showGlowEffect = true,
    this.glowColor,
    this.glowIntensity = 0.2,
    this.glowRadius = 16,
    this.glowSpreadRadius = 4,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the user taps this card.
  final VoidCallback? onTap;

  /// The amount of space to inset the [child].
  final EdgeInsetsGeometry padding;

  /// The amount of space to surround the card.
  final EdgeInsetsGeometry margin;

  /// The z-coordinate at which to place this card.
  final double? elevation;

  /// Whether to apply a glassmorphic effect to the card.
  final bool isGlassmorphic;

  /// The radius of the card's corners.
  final double? borderRadius;

  /// The card's background color.
  final Color? backgroundColor;

  /// The color to use for text and icons.
  final Color? foregroundColor;

  /// The color to use for the card's border.
  final Color? borderColor;

  /// The scale factor to apply when the card is hovered.
  final double hoverScale;

  /// The elevation to apply when the card is hovered.
  final double? hoverElevation;

  /// The duration of hover animations.
  final Duration animationDuration;

  /// The curve to use for hover animations.
  final Curve animationCurve;

  /// Whether to show a glow effect when the card is hovered.
  final bool showGlowEffect;

  /// The color of the glow effect.
  final Color? glowColor;

  /// The intensity of the glow effect (0.0 to 1.0).
  final double glowIntensity;

  /// The radius of the glow effect.
  final double glowRadius;

  /// The spread radius of the glow effect.
  final double glowSpreadRadius;

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
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: widget.animationCurve,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: widget.animationCurve,
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
    final defaultGlowColor = widget.glowColor ?? theme.colorScheme.primary;

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
                    color: defaultGlowColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                  // Hover glow effect
                  if (_isHovered && widget.showGlowEffect)
                    BoxShadow(
                      color: defaultGlowColor.withValues(
                          alpha: widget.glowIntensity * _glowAnimation.value),
                      blurRadius: widget.glowRadius,
                      spreadRadius:
                          widget.glowSpreadRadius * _glowAnimation.value,
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
                          (widget.backgroundColor ??
                                  theme.cardTheme.color ??
                                  Colors.white)
                              .withValues(
                                  alpha: widget.isGlassmorphic ? 0.7 : 0.95),
                          (widget.backgroundColor ??
                                  theme.cardTheme.color ??
                                  Colors.white)
                              .withValues(
                                  alpha: widget.isGlassmorphic ? 0.5 : 0.85),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                      border: Border.all(
                        color: (widget.borderColor ?? defaultGlowColor)
                            .withValues(alpha: _isHovered ? 0.2 : 0.1),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onTap,
                        borderRadius: BorderRadius.circular(radius),
                        splashColor: defaultGlowColor.withValues(alpha: 0.1),
                        highlightColor:
                            defaultGlowColor.withValues(alpha: 0.05),
                        child: Padding(
                          padding: widget.padding,
                          child: DefaultTextStyle(
                            style:
                                (theme.textTheme.bodyLarge ?? const TextStyle())
                                    .copyWith(
                              color: widget.foregroundColor ??
                                  theme.colorScheme.onSurface,
                            ),
                            child: IconTheme(
                              data: IconThemeData(
                                color: widget.foregroundColor ??
                                    theme.colorScheme.onSurface,
                              ),
                              child: widget.child,
                            ),
                          ),
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
