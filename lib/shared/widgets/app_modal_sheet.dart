import 'package:flutter/material.dart';

class AppModalSheet extends StatelessWidget {
  final Widget child;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  const AppModalSheet({
    super.key,
    required this.child,
    this.initialChildSize = 0.7,
    this.minChildSize = 0.5,
    this.maxChildSize = 0.95,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double initialChildSize = 0.7,
    double minChildSize = 0.5,
    double maxChildSize = 0.95,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppModalSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                child,
              ],
            ),
          ),
        );
      },
    );
  }
}
