import 'package:flutter/material.dart';

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height); // Left Bottom
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 40, // Control point
      size.width,
      size.height, // Right Bottom
    );
    path.lineTo(size.width, 0); // Right Top
    path.close(); // Close Path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
