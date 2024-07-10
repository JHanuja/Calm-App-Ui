
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';

class PlayButton extends StatefulWidget {
  Animation<double> animation;

  PlayButton({required this.animation});

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  late CurvedAnimation curve;

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
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.75,
              curve.value)!,
      child: Padding(
        padding:
            EdgeInsets.all(ScreenProperties.of(context).screenValues.value8),
        child: Container(
            width: ScreenProperties.of(context).screenValues.width * 0.35,
            height:
                ScreenProperties.of(context).screenValues.safeAreaHeight * 0.08,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                Transform(
                  transform: Matrix4.translationValues(
                      ScreenProperties.of(context).screenValues.width * -0.1,
                      0.0,
                      0.0),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Color.fromRGBO(6, 18, 113, 1.0),
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      ScreenProperties.of(context).screenValues.width * 0.05,
                      0.0,
                      0.0),
                  child: Center(
                    child: Text(
                      'Play',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize:
                            ScreenProperties.of(context).screenValues.value16,
                        color: Color.fromRGBO(6, 18, 113, 1.0),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}