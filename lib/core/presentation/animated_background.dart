import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:dream/config/theme/theme_cubit.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
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
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final shouldAnimate =
            state.profile?.preferences['closeBackgroundAnimation'] as bool? ??
                true;

        if (!shouldAnimate) {
          _controller.stop();
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-1, -1),
                end: const Alignment(1, 1),
                colors: isDarkMode
                    ? [
                        theme.colorScheme.surface.withOpacity(0.95),
                        theme.colorScheme.surfaceContainerHighest
                            .withOpacity(0.85),
                        theme.colorScheme.surfaceContainerHighest
                            .withOpacity(0.8),
                        theme.colorScheme.surface.withOpacity(0.9),
                      ]
                    : [
                        theme.colorScheme.primary.withOpacity(0.15),
                        theme.colorScheme.surface.withOpacity(0.2),
                        theme.colorScheme.surfaceContainerHighest
                            .withOpacity(0.18),
                        theme.colorScheme.secondary.withOpacity(0.15),
                      ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          );
        }

        if (_controller.status != AnimationStatus.forward) {
          _controller.repeat();
        }

        return Stack(
          children: [
            // Animated gradient background
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(
                        math.cos(_controller.value * 2 * math.pi),
                        math.sin(_controller.value * 2 * math.pi),
                      ),
                      end: Alignment(
                        -math.sin(_controller.value * 2 * math.pi),
                        math.cos(_controller.value * 2 * math.pi),
                      ),
                      colors: isDarkMode
                          ? [
                              theme.colorScheme.surface.withOpacity(0.95),
                              theme.colorScheme.surfaceContainerHighest
                                  .withOpacity(0.85),
                              theme.colorScheme.surfaceContainerHighest
                                  .withOpacity(0.8),
                              theme.colorScheme.surface.withOpacity(0.9),
                            ]
                          : [
                              theme.colorScheme.primary.withOpacity(0.15),
                              theme.colorScheme.surface.withOpacity(0.2),
                              theme.colorScheme.surfaceContainerHighest
                                  .withOpacity(0.18),
                              theme.colorScheme.secondary.withOpacity(0.15),
                            ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                  ),
                );
              },
            ),
            // Animated stars background
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarfieldPainter(
                    color: isDarkMode
                        ? Colors.white
                        : theme.colorScheme.primary.withOpacity(0.8),
                    animation: _controller.value,
                    starCount: isDarkMode ? 200 : 150,
                    opacity: isDarkMode ? 0.5 : 0.8,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class StarfieldPainter extends CustomPainter {
  final Color color;
  final double animation;
  final int starCount;
  final double opacity;
  final List<Star> stars;

  StarfieldPainter({
    required this.color,
    required this.animation,
    required this.opacity,
    this.starCount = 200,
  }) : stars = List.generate(starCount, (index) {
          final random = math.Random(index);
          return Star(
            x: random.nextDouble(),
            y: random.nextDouble(),
            size: random.nextDouble() * 2 + 1,
            brightness: random.nextDouble(),
            speed: random.nextDouble() * 0.3 + 0.1,
          );
        });

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      final yOffset = (animation * star.speed * size.height) % size.height;
      final y = (star.y * size.height + yOffset) % size.height;
      final paint = Paint()
        ..color = color.withOpacity(
          ((math.sin(animation * 2 * math.pi * star.speed +
                          star.brightness * 2 * math.pi) +
                      1) /
                  2 *
                  opacity +
              0.1),
        )
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);

      final position = Offset(
        star.x * size.width,
        y,
      );

      canvas.drawCircle(position, star.size, paint);
    }
  }

  @override
  bool shouldRepaint(StarfieldPainter oldDelegate) => true;
}

class Star {
  final double x;
  final double y;
  final double size;
  final double brightness;
  final double speed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.brightness,
    required this.speed,
  });
}
