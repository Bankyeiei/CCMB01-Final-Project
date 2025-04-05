import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double radius;
  final Color color;
  const Circle({
    super.key,
    required this.radius,
    required this.color,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
