import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'prediction.dart';
import 'shadow_of_doubt.dart';
import 'sphere_of_destiny.dart';
import 'window_of_opportunity.dart';

class Magic8Ball extends StatefulWidget {
  const Magic8Ball({Key? key}) : super(key: key);

  @override
  _Magic8BallState createState() => _Magic8BallState();
}

class _Magic8BallState extends State<Magic8Ball>
    with SingleTickerProviderStateMixin {
  static const lightSource = Offset(0, -0.75);
  String prediction = 'The MAGIC\n8-Ball';
  static const restPosition = Offset(0, -0.15);
  Offset tapPosition = Offset.zero;
  double wobble = 0.0;

  late AnimationController controller; // 2
  late Animation<double> animation;

// 3
  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 1500));
    controller.addListener(() => setState(() => null));

    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.elasticIn);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final windowPosition =
        Offset.lerp(restPosition, tapPosition, animation.value)!;
    final size = Size.square(MediaQuery.of(context).size.shortestSide);

    void _update(Offset position, Size size) {
      Offset tapPosition = Offset((2 * position.dx / size.width) - 1,
          (2 * position.dy / size.height) - 1);
      if (tapPosition.distance > 0.85) {
        tapPosition = Offset.fromDirection(tapPosition.direction, 0.85);
      }

      setState(() => this.tapPosition = tapPosition);
    }

    void _start(Offset offset, Size size) {
      controller.forward(from: 0);
      _update(offset, size);
    }

    void _end() {
      final rand = math.Random();
      prediction = predictions[rand.nextInt(predictions.length)];
      controller.reverse(from: 1);
      wobble = rand.nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    }

    return Stack(
      children: [
        ShadowOfDoubt(
          diameter: size.shortestSide,
        ),
        GestureDetector(
          onPanStart: (details) => _start(details.localPosition, size),
          onPanUpdate: (details) => _update(details.localPosition, size),
          onPanEnd: (_) => _end(),
          child: SphereOfDestiny(
              lightSource: lightSource,
              diameter: size.shortestSide,
              child: Transform(
                  origin: size.center(Offset.zero),
                  transform: Matrix4.identity()
                    ..translate(
                      windowPosition.dx * size.width / 2,
                      windowPosition.dy * size.height / 2,
                    )
                    ..scale(0.5 - 0.15 * windowPosition.distance)
                    //the order of ROTATES MATTER!
                    ..rotateZ(windowPosition.direction)
                    ..rotateY(windowPosition.distance * math.pi / 2)
                    ..rotateZ(-windowPosition.direction),
                  child: WindowOfOpportunity(
                    lightSource: lightSource - windowPosition,
                    child: Opacity(
                      opacity: 1 - controller.value,
                      child: Transform.rotate(
                        angle: wobble,
                        child: Prediction(
                          text: prediction,
                        ),
                      ),
                    ),
                  ))),
        )
      ],
    );
  }
}
