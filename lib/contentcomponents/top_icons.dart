import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/contentcomponents/meditation_content.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/menuScreen.dart';

class TopIcons extends AnimatedWidget {
  Animation animation;
  double width;
  double safeAreaHeight;

  void navigateBack() {
    var x = meditationContentKey.currentState as MeditationContentState;
    x.reverseMeditationTextAndListAnimation();
  }

  TopIcons({required this.animation, required this.width, required this.safeAreaHeight})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: safeAreaHeight * 0.03,
          left: (ScreenProperties.of(context).screenValues.width * 2 * -1) +
              lerpDouble(
                  0.0,
                  ScreenProperties.of(context).screenValues.width * 2 +
                      ScreenProperties.of(context).screenValues.width * 0.05,
                  animation.value)!,
          child: Padding(
            padding: EdgeInsets.all(
                ScreenProperties.of(context).screenValues.value8),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => navigateBack(),
            ),
          ),
        ),
        Positioned(
            top: safeAreaHeight * 0.03,
            right: (ScreenProperties.of(context).screenValues.width * 2 * -1) +
                lerpDouble(
                    0.0,
                    ScreenProperties.of(context).screenValues.width * 2 +
                        ScreenProperties.of(context).screenValues.width * 0.05,
                    animation.value)!,
            child: Padding(
              padding: EdgeInsets.all(
                  ScreenProperties.of(context).screenValues.value8),
              child: IconButton(
                icon: Icon(Icons.file_upload, color: Colors.white),
                onPressed: () {},
              ),
            )),
      ],
    );
  }
}
