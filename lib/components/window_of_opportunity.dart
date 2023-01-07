import 'package:flutter/material.dart';
import 'dart:math' as math;

class WindowOfOpportunity extends StatelessWidget {
  const WindowOfOpportunity({
    Key? key,
    required this.lightSource,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Offset lightSource;

  @override
  Widget build(BuildContext context) {
    final innerShadowWidth = lightSource.distance * 0.1;
    final portalShadowOffset = Offset.fromDirection(
      math.pi + lightSource.direction,
      innerShadowWidth,
    );

    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: Alignment(portalShadowOffset.dx, portalShadowOffset.dy),
              stops: [
                1 - innerShadowWidth,
                1,
              ],
              colors: const [
                Color(0x661F1F1F),
                Colors.black,
              ],
            )),
        child: child);
  }
}
