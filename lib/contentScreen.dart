import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterdesignchallange_calmapp/contentcomponents/meditation_time.dart';
import 'package:flutterdesignchallange_calmapp/contentcomponents/play_meditation.dart';
import 'package:flutterdesignchallange_calmapp/contentcomponents/scaled_image.dart';
import 'package:flutterdesignchallange_calmapp/helper.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';

import 'contentcomponents/meditation_content.dart';
import 'contentcomponents/play_button.dart';
import 'contentcomponents/top_icons.dart';

class ContentScreen extends AnimatedWidget {
  double heightParentTop;
  double width;
  double height;
  double imageTargetHeight;
  double completeScreenHeight;
  double safeAreaHeight;
  String imagePath;
  Animation<double> animation;
  double imageHeight;
  double imageWidth;
  double imageX;
  double imageY;
  Meditation meditation;

  ContentScreen({
    required this.heightParentTop,
    required this.width,
    required this.height,
    required this.imageTargetHeight,
    required this.completeScreenHeight,
    required this.safeAreaHeight,
    required this.imagePath,
    required this.animation,
    required this.imageHeight,
    required this.imageWidth,
    required this.imageX,
    required this.imageY,
    required this.meditation,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Make Screen blue
        Positioned(
          top: safeAreaHeight * 0.37,
          child: Container(
              color: Color.fromRGBO(6, 18, 113, 1.0),
              width: width,
              height: safeAreaHeight * 0.63),
        ),
        

        ScaledImage(
            meditation: meditation,
            imageTargetHeight: imageTargetHeight,
            completeScreenHeight: completeScreenHeight,
            completeScreenWidth: width,
            safeAreaHeight: safeAreaHeight,
            imagePath: imagePath,
            animation: animation,
            imageHeight: imageHeight,
            imageX: imageX,
            imageY: imageY,
            heightParentTop: heightParentTop,
            imageWidth: imageWidth),
        TopIcons(
            animation: animation, width: width, safeAreaHeight: safeAreaHeight),
        PlayButton(animation: animation),
        MeditationTime(animation: animation, meditation: meditation),
        MeditationContent(animation: animation, meditation: meditation),
        PlayMeditation(meditation:meditation),



      ],
    );
  }
}










