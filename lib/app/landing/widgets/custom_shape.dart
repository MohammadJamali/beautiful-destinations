import 'dart:ui';
import 'package:flutter/material.dart';

import 'custom_shape/clipper.dart';

class CustomShape extends StatelessWidget {
  final double? width;
  final double? height;
  final double blur;
  final Color backgroundColor;
  final Widget child;

  const CustomShape({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.blur = 5.0,
    this.backgroundColor = Colors.white38,
  }) : assert(blur >= 0, "Blur amount should be non-negative");

  @override
  Widget build(BuildContext context) {
    final content = Container(
      color: backgroundColor,
      width: width,
      height: height,
      child: child,
    );

    return ClipPath(
      clipper: LandingShapeClipper(),
      child: blur > 0
          ? BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blur,
                sigmaY: blur,
              ),
              child: content,
            )
          : content,
    );
  }
}
