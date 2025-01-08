import 'package:flutter/material.dart';

/// A customizable card widget that follows the app's theme guidelines.
class AppCard extends StatelessWidget {
  /// Creates an AppCard with required child widget.
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(8),
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      margin: margin,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    return onTap != null
        ? InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: card,
          )
        : card;
  }
}
