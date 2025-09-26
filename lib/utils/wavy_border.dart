import 'package:flutter/material.dart';

class WavyBorder extends ShapeBorder {
  const WavyBorder({this.radius = 32});

  final double radius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      // The top curve is above this container's Rect, keep this in mind with your other Widgets
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy - radius)
      // The 90 degree arc at the top
      ..relativeArcToPoint(
        Offset(radius, radius),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      // The horizontal line
      ..lineTo(rect.topRight.dx - radius, rect.topRight.dy)
      // The 90 degree arc at the bottom
      ..relativeArcToPoint(
        Offset(radius, radius),
        radius: Radius.circular(radius),
      )
      // Then just visit the bottom corners normally
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }
}
