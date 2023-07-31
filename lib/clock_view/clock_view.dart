import 'package:clock_with_custom_painter/clock_view/clock_widget.dart';
import 'package:flutter/material.dart';

class ClockView extends StatelessWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xFF2D2F41),
        child: const ClockWidget(),
      ),
    );
  }
}
