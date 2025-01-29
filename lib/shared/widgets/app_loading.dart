import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoading extends StatelessWidget {
  final double size;
  final Color? color;
  final LoadingStyle style;

  const AppLoading({
    super.key,
    this.size = 50.0,
    this.color,
    this.style = LoadingStyle.doubleBounce,
  });

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? Theme.of(context).colorScheme.primary;

    switch (style) {
      case LoadingStyle.doubleBounce:
        return SpinKitDoubleBounce(
          color: loadingColor,
          size: size,
        );
      case LoadingStyle.wave:
        return SpinKitWave(
          color: loadingColor,
          size: size,
        );
      case LoadingStyle.circle:
        return SpinKitCircle(
          color: loadingColor,
          size: size,
        );
      case LoadingStyle.fadingCircle:
        return SpinKitFadingCircle(
          color: loadingColor,
          size: size,
        );
      case LoadingStyle.pulse:
        return SpinKitPulse(
          color: loadingColor,
          size: size,
        );
    }
  }
}

enum LoadingStyle {
  doubleBounce,
  wave,
  circle,
  fadingCircle,
  pulse,
}

class AppLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color? barrierColor;
  final LoadingStyle loadingStyle;

  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.barrierColor,
    this.loadingStyle = LoadingStyle.doubleBounce,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: barrierColor ?? Colors.black.withValues(alpha: 0.3),
            child: Center(
              child: AppLoading(
                style: loadingStyle,
              ),
            ),
          ),
      ],
    );
  }
}
