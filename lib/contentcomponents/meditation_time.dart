import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';

class MeditationTime extends StatefulWidget {
  Animation animation;
  Meditation meditation;

  MeditationTime({this.animation, this.meditation});

  @override
  _MeditationTimeState createState() => _MeditationTimeState();
}

class _MeditationTimeState extends State<MeditationTime> {
  CurvedAnimation curve;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curve = CurvedAnimation(parent: widget.animation, curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ScreenProperties.of(context).screenValues.safeAreaHeight -
          lerpDouble(
              0.0,
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.7,
              curve.value),
      left: lerpDouble(0.0,
          ScreenProperties.of(context).screenValues.width * 0.75, curve.value),
      child: Text(
        '00:10:00',
        style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: ScreenProperties.of(context).screenValues.value16),
      ),
    );
  }
}