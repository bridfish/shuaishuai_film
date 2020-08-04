import 'dart:math';

import 'package:flutter/material.dart';

class ToggleRotate extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final double rad;
  final int durationMs;
  final bool clockwise;
  final Curve curve;

  ToggleRotate({this.child, @required this.onTap, this.rad = pi, this.clockwise = true,this.durationMs=200, this.curve = Curves.fastOutSlowIn});

  @override
  _ToggleRotateState createState() => _ToggleRotateState();
}

class _ToggleRotateState extends State<ToggleRotate> with SingleTickerProviderStateMixin {
  double _rad = 0;
  bool _rotated = false;
  AnimationController _controller;
  Animation _rotate;

  @override
  void initState() {
    _controller =
    AnimationController(duration: Duration(milliseconds: widget.durationMs), vsync: this)
      ..addListener(() => setState(() => _rad = (_rotated?(1 - _rotate.value):_rotate.value) * widget.rad))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _rotated = !_rotated;
        }
      });
    _rotate = CurvedAnimation(parent: _controller, curve: widget.curve);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.reset();
        _controller.forward();
        widget.onTap();
      },
      child: Transform(
        transform: Matrix4.rotationZ(widget.clockwise ? _rad : -_rad),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}