
import 'dart:math';

import 'package:flutter/material.dart';

class CirclePath extends CustomClipper<Path> {
  CirclePath(this.value);

  final double value;

  @override
  Path getClip(Size size) {
    var path = Path();
    double radius =
        value * sqrt(size.height * size.height + size.width * size.width);
    path.addOval(Rect.fromLTRB(
        size.width - radius, -radius, size.width + radius, radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}