import 'dart:math';

import 'package:flutter/material.dart';

class PaintPage extends StatefulWidget {
  const PaintPage({Key? key}) : super(key: key);

  @override
  State<PaintPage> createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> with TickerProviderStateMixin {
  var _sides = 3.0;

  late final Animation<double> animation;
  late final AnimationController controller;

  late final Animation<double> animation2;
  late final AnimationController controller2;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    Tween<double> _radiusTween = Tween(begin: 30, end: 200);
    Tween<double> _rotationTween = Tween(begin: -pi, end: pi);

    animation = _rotationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    animation2 = _radiusTween.animate(controller2)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });

    controller.forward();
    controller2.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Рисование"),
      ),
      body: CustomPaint(
        painter: ShapePainter(
          _sides,
          animation2.value,
          animation.value,
        ),
        child: Container(),
      ),
    );
  }
}

// FOR PAINTING POLYGONS
class ShapePainter extends CustomPainter {
  final double sides;
  final double radius;
  final double radians;
  ShapePainter(this.sides, this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = animatedColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();

    var angle = (pi * 2) / sides;

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint = Offset(radius * cos(radians), radius * sin(radians));

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 1; i <= sides; i++) {
      double x = radius * cos(radians + angle * i) + center.dx;
      double y = radius * sin(radians + angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  Color get animatedColor {
    return HSVColor.lerp(
      HSVColor.fromColor(Colors.deepOrangeAccent),
      HSVColor.fromColor(Colors.deepPurpleAccent),
      1 + sin(radians),
    )!
        .toColor();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
