import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clock_with_custom_painter/clock_view/widget/clock_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(milliseconds: 1),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);
    String formattedDate = DateFormat('E, d MMM').format(now);
    String formattedOnlyMin = DateFormat('mm').format(now);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   height: 100,
          //   width: 100,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       const Flexible(
          //         child: CustomSlidingText(word: 'word', interval: 800, isDelay: true),
          //         fit: FlexFit.tight,
          //       ),
          //       const Flexible(
          //         child: CustomSlidingText(word: 'word 2', interval: 800, isDelay: true),
          //         fit: FlexFit.tight,
          //       ),
          //     ],
          //   ),
          // ),
          Text(
            formattedTime,
            style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold),
          ),
          Text(
            formattedDate,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          SizedBox(
            height: 300,
            width: 300,
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                painter: ClockPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSlidingText extends StatefulWidget {
  const CustomSlidingText({Key? key, required this.word, required this.interval, required this.isDelay})
      : super(key: key);

  final String word;
  final int interval;
  final bool isDelay;

  @override
  State<CustomSlidingText> createState() => _CustomSlidingTextState();
}

class _CustomSlidingTextState extends State<CustomSlidingText> with SingleTickerProviderStateMixin {
  late AnimationController _animControllerSlideIn;
  late Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    _animControllerSlideIn =
        AnimationController(duration: Duration(milliseconds: widget.interval), vsync: this);

    _slideIn = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _animControllerSlideIn, curve: Curves.easeOut));

    if (widget.isDelay) {
      Future.delayed(Duration(milliseconds: 800), () {
        _animControllerSlideIn.forward();
        _animControllerSlideIn.repeat();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideIn,
      child: Text(
        widget.word,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
