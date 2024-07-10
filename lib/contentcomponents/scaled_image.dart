import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';

class ScaledImage extends StatefulWidget {
  Animation<double> animation;
  String imagePath;
  double heightParentTop;
  double imageHeight;
  double imageWidth;
  double imageX;
  double imageY;
  double completeScreenHeight;
  double safeAreaHeight;
  double completeScreenWidth;
  double imageTargetHeight;
  Meditation meditation;
  ScaledImage(
      {required this.animation,
      required this.imagePath,
      required this.heightParentTop,
      required this.imageHeight,
      required this.imageX,
      required this.imageY,
      required this.safeAreaHeight,
      required this.completeScreenHeight,
      required this.completeScreenWidth,
      required this.imageWidth,
      required this.imageTargetHeight,
      required this.meditation});

  @override
  _ScaledImageState createState() => _ScaledImageState();
}

class _ScaledImageState extends State<ScaledImage> {
  late CurvedAnimation _easeOutCubic;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _easeOutCubic =
        CurvedAnimation(parent: widget.animation, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.animation.value == 0
          ? widget.imageY -
              (widget.completeScreenHeight - widget.safeAreaHeight)
          : -1 *
              lerpDouble(
                  -1 *
                      (widget.imageY -
                          (widget.completeScreenHeight -
                              widget.safeAreaHeight)!),
                  0.0,
                  _easeOutCubic.value)!,
      left: widget.animation.value == 0
          ? widget.imageX
          : -1 * (lerpDouble(widget.imageX * -1, 0.0, _easeOutCubic.value)!),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Container(
              height: widget.animation.value == 0
                  ? widget.imageHeight
                  : lerpDouble(widget.imageHeight, widget.imageTargetHeight,
                      _easeOutCubic.value),
              width: widget.animation.value == 0
                  ? widget.imageWidth
                  : lerpDouble(widget.imageWidth, widget.completeScreenWidth,
                      _easeOutCubic.value),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    widget.imagePath,
                  ),
                ),
              ),
            ),
          ),
          widget.animation.value > 0.3
              ? Container(
                  height: lerpDouble(widget.imageHeight,
                      widget.imageTargetHeight, _easeOutCubic.value),
                  width: lerpDouble(widget.imageWidth,
                      widget.completeScreenWidth, _easeOutCubic.value),
                  child: Align(
                    alignment: FractionalOffset(0.0,
                        -1 * (lerpDouble(-1.0, -0.6, _easeOutCubic.value)!)),
                    child: Stack(
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              0.0,
                              ScreenProperties.of(context).screenValues.width *
                                  -0.083,
                              0.0),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenProperties.of(context)
                                .screenValues
                                .value8),
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(
                                    ScreenProperties.of(context)
                                            .screenValues
                                            .value8 /
                                        2),
                                child: Text(widget.meditation.contentType,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: ScreenProperties.of(context)
                                            .screenValues
                                            .value12)),
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(2, 7, 48, 1.0),
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenProperties.of(context)
                                  .screenValues
                                  .safeAreaHeight *
                              0.09,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.meditation.name,
                            style: TextStyle(
                                fontSize: lerpDouble(
                                    ScreenProperties.of(context)
                                        .screenValues
                                        .value16,
                                    ScreenProperties.of(context)
                                        .screenValues
                                        .value32,
                                    widget.animation.value),
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}