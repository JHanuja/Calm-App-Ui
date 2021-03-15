import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/contentcomponents/play_meditation.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/menuScreen.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';

GlobalKey meditationContentKey = GlobalKey(debugLabel: "meditationContent");

class MeditationContent extends StatefulWidget {
  final Animation animation;
  final Meditation meditation;

  MeditationContent({this.animation, this.meditation})
      : super(key: meditationContentKey);

  @override
  MeditationContentState createState() => MeditationContentState();
}

class MeditationContentState extends State<MeditationContent>
    with TickerProviderStateMixin {
  AnimationController _meditationTextController;
  AnimationController _meditationListController;
  bool started = false;
  PlayMeditationState _playmeditationState;

  Offset scrollOfsset = Offset(0.0, 0.0);

  void reverseMeditationTextAndListAnimation() {
    _meditationListController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        print('called reverse.....');
        var x = menuScreenKey.currentState as MenuScreenState;
        x.reverseAnimation();
      }
    });
    _meditationListController.reverse();
    _meditationTextController.reverse();
    _playmeditationState.startFadingOut();
  }

  @override
  void initState() {
    

    _meditationTextController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 250));
    _meditationListController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
        reverseDuration: const Duration(milliseconds: 300));

    widget.animation.addListener(() {
      if (widget.animation.value >= 0.5 && !started) {
        _meditationTextController.forward();
        started = true;
        print('called');
      }
    });

    _meditationTextController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _meditationListController.forward();
      }
    });

    _meditationListController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _playmeditationState =
        playmeditationkey.currentState as PlayMeditationState;
        _playmeditationState.startFadingIn();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: ScreenProperties.of(context).screenValues.safeAreaHeight * 0.37,
        child: Container(
            height:
                ScreenProperties.of(context).screenValues.safeAreaHeight * 0.63,
            width: ScreenProperties.of(context).screenValues.width,
            child: Stack(
              children: [
                MeditationText(
                  animation: _meditationTextController,
                  meditation: widget.meditation,
                ),
                MeditationList(
                    scrollOffset: scrollOfsset,
                    animation: _meditationListController,
                    meditation: widget.meditation),
              ],
            )));
  }
}

class MeditationList extends AnimatedWidget {
  final Animation animation;
  final Meditation meditation;
  Offset scrollOffset;

  Offset currentTranslation = Offset(0.0, 0.0);

  MeditationList({this.animation, this.meditation, this.scrollOffset})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ScreenProperties.of(context).screenValues.safeAreaHeight * 0.2,
      child: Container(
        height: animation.value < 1.0
            ? ScreenProperties.of(context).screenValues.safeAreaHeight * 0.43
            : ScreenProperties.of(context).screenValues.safeAreaHeight *
                0.31, //0.43-0.12(playmeditationheight)
        width: ScreenProperties.of(context).screenValues.width,
        child: SingleChildScrollView(
          child: Stack(
              children: createListItems(meditation, context,
                  ScreenProperties.of(context).screenValues.safeAreaHeight)),
        ),
      ),
    );
  }

  List<Widget> createListItems(
      Meditation meditation, BuildContext context, double safeAreaHeight) {
    List<Widget> list = [];

    list.add(Container(
        height: (meditation.playlist.length) *
            (safeAreaHeight * 0.1) *
            1.25 //ListItems * Listitemheight
        ));

    for (int i = 0; i < meditation.playlist.length; ++i) {
      list.add(
        PlayListItemCard(
          index: i,
          item: meditation.playlist[i],
          animation: animation,
        ),
      );
    }

    return list;
  }
}

class PlayListItemCard extends StatefulWidget {
  int index;
  PlayListItem item;
  Animation animation;

  PlayListItemCard({this.index, this.item, this.animation});

  @override
  _PlayListItemCardState createState() => _PlayListItemCardState();
}

class _PlayListItemCardState extends State<PlayListItemCard> {
  CurvedAnimation _curve;
  Animation<double> _animation;

  @override
  void initState() {
    _curve = CurvedAnimation(
        parent: widget.animation,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ));
    _animation = Tween<double>(begin: 0.0, end: 300.0).animate(_curve);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = ScreenProperties.of(context).screenValues.safeAreaHeight * 0.1;
    var width = ScreenProperties.of(context).screenValues.width;
    return Positioned(
      top: widget.index * height * 1.25 +
          (widget.index * height * 1.75 -
              lerpDouble(0.0, widget.index * height * 1.75, _curve.value)),
      child: _curve.value > 0.0
          ? Transform(
              transform:
                  Matrix4.translationValues(0.0, 300.0 - _animation.value, 0.0),
              child: Padding(
                padding: EdgeInsets.all(
                    ScreenProperties.of(context).screenValues.value8),
                child: Container(
                  height: height,
                  width: width,
                  child: Row(
                    children: [
                      Container(
                        height: height,
                        width: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              widget.item.imagePath,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenProperties.of(context)
                                      .screenValues
                                      .value32,
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                widget.item.name,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenProperties.of(context)
                                        .screenValues
                                        .value16),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenProperties.of(context)
                                      .screenValues
                                      .value32,
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                widget.item.description,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: ScreenProperties.of(context)
                                            .screenValues
                                            .value8 *
                                        1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height,
                        width: width * 0.2,
                        child: Center(
                          child: Text(
                            widget.item.minutes.toString() +
                                ":" +
                                widget.item.seconds.toString(),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: ScreenProperties.of(context)
                                    .screenValues
                                    .value16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}

class MeditationText extends AnimatedWidget {
  final Animation animation;
  final Meditation meditation;

  MeditationText({this.animation, this.meditation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -1 * ScreenProperties.of(context).screenValues.width +
          lerpDouble(0, ScreenProperties.of(context).screenValues.width,
              animation.value),
      child: Container(
        width: ScreenProperties.of(context).screenValues.width,
        height: ScreenProperties.of(context).screenValues.safeAreaHeight * 0.2,
        child: Padding(
          padding:
              EdgeInsets.all(ScreenProperties.of(context).screenValues.value8),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              meditation.text,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: ScreenProperties.of(context).screenValues.value16),
            ),
          ),
        ),
      ),
    );
  }
}
