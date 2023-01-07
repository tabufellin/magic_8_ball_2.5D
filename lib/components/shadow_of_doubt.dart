import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShadowOfDoubt extends StatelessWidget {
  const ShadowOfDoubt({
    Key? key,
    required this.diameter,
  }) : super(key: key);

  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.identity()..rotateX(math.pi / 2.1),
        origin: Offset(0, diameter),
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 25, color: Colors.grey.withOpacity(0.6))
            ],
            shape: BoxShape.circle,
          ),
        ));
  }
}
