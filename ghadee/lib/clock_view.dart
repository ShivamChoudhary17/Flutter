import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key? key, required this.size}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer timer;
  /*--INIT-STATE--*/
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  /*-- DISPOSE --*/
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  /*--BUILD-STATE--*/
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi / 2, //
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  // For Each Minute and Second
  // 60 sec takes 360 degree rotation so 1 sec will take 6degree
  // For Each Hour Hand
  // 12 hour = 360 degree. so,1hr = 30deg, 1min = 0.5deg

  @override
  void paint(Canvas canvas, Size size) {
    var centreX = size.width / 2;
    var centreY = size.height / 2;
    var center = Offset(centreX, centreY);
    var radius = min(centreX, centreY);
    var fillBrush = Paint()..color = Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var secHandleBrush = Paint()
      ..color = Colors.orangeAccent.shade200
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;

    var minHandleBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;

    var hourHandleBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;

    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    /*--HR-*/
    var hourHandX = centreX +
        radius * 0.4 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi /
    180);
    var hourHandY = centreX +
        radius * 0.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandleBrush);
    /*--MIN-*/
    var minHandX = centreX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centreX + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandleBrush);
    /*--SEC-*/
    var secHandX = centreX + radius * 0.8 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centreX + radius * 0.8 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandleBrush);
    /*--MIDDLE DOT-*/
    canvas.drawCircle(center, radius * 0.12, centerFillBrush);

    /*--LINE AROUND CLOCK--*/
    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centreX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centreY + outerCircleRadius * sin(i * pi / 180);

      var x2 = centreX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centreY + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
