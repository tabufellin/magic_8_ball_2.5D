import 'package:flutter/material.dart';

class SphereOfDestiny extends StatelessWidget {
  const SphereOfDestiny(
      {Key? key,
      required this.diameter,
      required this.lightSource,
      required this.child})
      : super(key: key);

  final double diameter;
  final Offset lightSource;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: const [
            Colors.grey,
            Colors.black,
          ],
          center: Alignment(lightSource.dx, lightSource.dy),
        ),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
