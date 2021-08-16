import 'dart:ui';
import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  final double _sigmaX = 3.0; // from 0 - 10
  final double _sigmaY = 3.0; // from 0 - 10
  final double _opacity = 0.0; // from 0 - 1.0

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
      child: Container(
        color: Colors.black.withOpacity(_opacity),
      ),
    );
  }
}
