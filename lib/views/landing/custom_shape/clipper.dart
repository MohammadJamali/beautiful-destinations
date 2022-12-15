import 'package:flutter/material.dart';

class LandingShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width * 0.06363636, size.height * 0.016);
    path.lineTo(size.width * 0.9363636, size.height * 0.016);
    path.arcToPoint(Offset(size.width * 0.9939394, size.height * 0.092),
        radius: Radius.elliptical(size.width * 0.05757576, size.height * 0.076),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path.lineTo(size.width * 0.9939394, size.height * 0.906);
    path.arcToPoint(Offset(size.width * 0.9363636, size.height * 0.982),
        radius: Radius.elliptical(size.width * 0.05757576, size.height * 0.076),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path.lineTo(size.width * 0.6973758, size.height * 0.982);
    path.cubicTo(
        size.width * 0.627253,
        size.height * 0.982,
        size.width * 0.6272848,
        size.height * 0.82,
        size.width * 0.5,
        size.height * 0.82);
    path.cubicTo(
        size.width * 0.37295,
        size.height * 0.820,
        size.width * 0.3730803,
        size.height * 0.982,
        size.width * 0.2878652,
        size.height * 0.982);
    path.lineTo(size.width * 0.06363636, size.height * 0.982);
    path.arcToPoint(Offset(size.width * 0.006060606, size.height * 0.906),
        radius: Radius.elliptical(size.width * 0.05757576, size.height * 0.076),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path.lineTo(size.width * 0.006060606, size.height * 0.092);
    path.arcToPoint(Offset(size.width * 0.06363636, size.height * 0.016),
        radius: Radius.elliptical(size.width * 0.05757576, size.height * 0.076),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// class LandingShapeClipperPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var fill = Paint()..style = PaintingStyle.fill;
//     fill.color = Colors.white.withOpacity(0.4);
//     canvas.drawPath(getClip(size), fill);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
