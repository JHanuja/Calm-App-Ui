import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/contentcomponents/meditation_content.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';

GlobalKey playmeditationkey = GlobalKey(debugLabel: 'playmeditation');

class PlayMeditation extends StatefulWidget {
  Meditation meditation;

  PlayMeditation({this.meditation}) : super(key: playmeditationkey);

  @override
  PlayMeditationState createState() => PlayMeditationState();
}

class PlayMeditationState extends State<PlayMeditation>
    with TickerProviderStateMixin {
  AnimationController _fadeInController;
  AnimationController _playedSconds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fadeInController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400),reverseDuration: const Duration(milliseconds: 200));
    _fadeInController.addListener(() {
      setState(() {});
    });
  }

  //gets started after list of meditation songs loaded

  void startFadingIn() {
    _fadeInController.forward();
  }
  void startFadingOut() {
    _fadeInController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    var playListItem =
        widget.meditation.playlist[widget.meditation.currentSong];
    return Positioned(
      top: ScreenProperties.of(context).screenValues.safeAreaHeight -
          lerpDouble(
              0.0,
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.12,
              _fadeInController.value),
      child: Container(
        width: ScreenProperties.of(context).screenValues.width,
        height: ScreenProperties.of(context).screenValues.safeAreaHeight * 0.12,
        color: Color.fromRGBO(6, 18, 113, 1.0),
        child: Column(
          children: [
            Container(
                height:
                    ScreenProperties.of(context).screenValues.safeAreaHeight *
                        0.008,
                width: ScreenProperties.of(context).screenValues.width,
                child: Stack(
                  children: [
                    Container(
                      color: Color.fromRGBO(1, 7, 40, 0.5),
                    ),
                    Container(
                      color: Colors.white,
                      width: lerpDouble(
                          0.0,
                          (playListItem.secondsPlayed /
                                  playListItem.secondsTotal) *
                              ScreenProperties.of(context).screenValues.width,
                          _fadeInController.value),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                color: Color.fromRGBO(1, 7, 40, 0.8),
                child: Row(
                  children: [
                    Container(
                      width:
                          ScreenProperties.of(context).screenValues.width * 0.2,
                      child: Padding(
                        padding: EdgeInsets.all(
                            ScreenProperties.of(context).screenValues.value16),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent, shape: BoxShape.circle),
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.play_arrow),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenProperties.of(context).screenValues.width *
                          0.05,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              playListItem.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: ScreenProperties.of(context)
                                      .screenValues
                                      .value16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              playListItem.description,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: ScreenProperties.of(context)
                                          .screenValues
                                          .value16 *
                                      0.7,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width:
                          ScreenProperties.of(context).screenValues.width * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.skip_next),
                                onPressed: () {},
                              ),
                            ),
                          ),

                          Expanded(
                            child: Container(
                                child: Row(
                              children: [
                                Text(
                                  (playListItem.secondsPlayed / 60)
                                          .round()
                                          .toString() +
                                      ":",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white),
                                ),
                                Text(
                                  (playListItem.secondsPlayed % 60)
                                      .round()
                                      .toString(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white),
                                ),
                                Text(
                                  '/',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  (playListItem.secondsTotal / 60)
                                          .round()
                                          .toString() +
                                      ":",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  (playListItem.secondsTotal % 60)
                                      .round()
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
