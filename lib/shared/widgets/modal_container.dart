import 'package:flutter/material.dart';
import 'dart:ui';

class ModalContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final Color? backgroundColor;

  const ModalContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 28,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color:
                backgroundColor ?? theme.colorScheme.surface.withOpacity(0.8),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius)),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.1),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
