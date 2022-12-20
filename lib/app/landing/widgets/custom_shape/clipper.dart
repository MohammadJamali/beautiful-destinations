import 'package:flutter/material.dart';

class LandingShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..moveTo(
        size.width * 0.06363636,
        size.height * 0.016,
      )
      ..lineTo(
        size.width * 0.9363636,
        size.height * 0.016,
      )
      ..arcToPoint(
        Offset(
          size.width * 0.9939394,
          size.height * 0.092,
        ),
        radius: Radius.elliptical(
          size.width * 0.05757576,
          size.height * 0.076,
        ),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      )
      ..lineTo(
        size.width * 0.9939394,
        size.height * 0.906,
      )
      ..arcToPoint(
        Offset(
          size.width * 0.9363636,
          size.height * 0.982,
        ),
        radius: Radius.elliptical(
          size.width * 0.05757576,
          size.height * 0.076,
        ),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      )
      ..lineTo(
        size.width * 0.6973758,
        size.height * 0.982,
      )
      ..cubicTo(
        size.width * 0.627253,
        size.height * 0.982,
        size.width * 0.6272848,
        size.height * 0.82,
        size.width * 0.5,
        size.height * 0.82,
      )
      ..cubicTo(
        size.width * 0.37295,
        size.height * 0.820,
        size.width * 0.3730803,
        size.height * 0.982,
        size.width * 0.2878652,
        size.height * 0.982,
      )
      ..lineTo(
        size.width * 0.06363636,
        size.height * 0.982,
      )
      ..arcToPoint(
        Offset(
          size.width * 0.006060606,
          size.height * 0.906,
        ),
        radius: Radius.elliptical(
          size.width * 0.05757576,
          size.height * 0.076,
        ),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      )
      ..lineTo(
        size.width * 0.006060606,
        size.height * 0.092,
      )
      ..arcToPoint(
        Offset(
          size.width * 0.06363636,
          size.height * 0.016,
        ),
        radius: Radius.elliptical(
          size.width * 0.05757576,
          size.height * 0.076,
        ),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
