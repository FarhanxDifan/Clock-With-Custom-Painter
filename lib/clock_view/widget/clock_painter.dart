import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    // main circle
    var mainCircle = Paint()..color = const Color(0xFF454975);
    canvas.drawCircle(center, radius - 8, mainCircle);

    // stroke circle
    var strokeCircle = Paint()
      ..color = const Color(0xFFE5E8FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    canvas.drawCircle(center, radius, strokeCircle);

    // hour line
    var hourLine = Paint()
      ..color = const Color(0xFFDB78D1)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var hourHandX = centerX + 70 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX + 70 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourLine);

    // min line

    var minLine = Paint()
      ..color = const Color(0xFF77B7FF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var minHandX = centerX + 95 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 95 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minLine);

    // seconds line

    var secondLine = Paint()
      ..color = const Color(0xFFF9B979)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var secHandX = centerX + 120 * cos((dateTime.second * 6 + dateTime.millisecond * 0.006) * pi / 180);
    var secHandY = centerX + 120 * sin((dateTime.second * 6 + dateTime.millisecond * 0.006) * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secondLine);

    // center dot
    var centerDot = Paint()..color = const Color(0xFFE5E8FF);
    canvas.drawCircle(center, 12, centerDot);

    // dash

    var dashBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    //for hour

    var bigouterCircleRadius = radius;
    var biginnerCircleRadius = radius - 20;
    for (double i = 0; i < 360; i += 30) {
      var x1 = centerX + bigouterCircleRadius * cos(i * pi / 180);
      var y1 = centerX + bigouterCircleRadius * sin(i * pi / 180);

      var x2 = centerX + biginnerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + biginnerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    var outerCircleRadius = radius - 14;
    var innerCircleRadius = radius - 16;
    for (double i = 0; i < 360; i += 6) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
