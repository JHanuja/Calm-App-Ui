import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterdesignchallange_calmapp/contentScreen.dart';
import 'package:flutterdesignchallange_calmapp/helper.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/menucomponents/bottom_menu.dart';
import 'package:flutterdesignchallange_calmapp/menucomponents/favorites.dart';
import 'package:flutterdesignchallange_calmapp/menucomponents/recently_played.dart';
import 'package:flutterdesignchallange_calmapp/menucomponents/title_content.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';
import 'package:flutterdesignchallange_calmapp/screencontroller.dart';

GlobalKey menuScreenKey = GlobalKey(debugLabel: 'menuScreen');

class MenuScreen extends StatefulWidget {
  ScreenElements menuContent;
  MenuScreen({this.menuContent}) : super(key: menuScreenKey);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  ScreenController screenController;
  bool stackPosition = false;
  bool menuOnTop = true;
  AnimationController zeroSeconds;


  void reverseAnimation() {
    screenController.controller.reverse();
    screenController.controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setMenuOnTop();
      }
    });
  }

  void setMenuOnTop() async {
    await Future.delayed(const Duration(milliseconds: 200));
    //screenController = ScreenController(vsync: this);
    setState(() {
      menuOnTop = true;
    });
  }

  void changeStackPosition(bool x) {
    setState(() {
      stackPosition = x;
      menuOnTop = false;
    });
  }

  @override
  void initState() {
    super.initState();
    screenController = ScreenController(vsync: this);
    zeroSeconds = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> favrec = [
      Favorites(
          imageTargetHeight:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.37,
          completeScreenHeight:
              ScreenProperties.of(context).screenValues.completeScreenHeight,
          func: screenController.open,
          animation: screenController.controller,
          safeAreaHeight:
              ScreenProperties.of(context).screenValues.safeAreaHeight,
          heightParentMiddle:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.35,
          heightParentTop:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.37,
          color: Color.fromRGBO(6, 18, 113, 1.0),
          height:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.28,
          width: ScreenProperties.of(context).screenValues.width,
          meditations: widget.menuContent.favorites),
      RecentlyPlayed(
          imageTargetHeight:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.37,
          completeScreenHeight:
              ScreenProperties.of(context).screenValues.completeScreenHeight,
          safeAreaHeight:
              ScreenProperties.of(context).screenValues.safeAreaHeight,
          heightParentTop:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.37,
          heightParentBottom:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.28,
          height:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.35,
          width: ScreenProperties.of(context).screenValues.width,
          color: Color.fromRGBO(6, 18, 113, 1.0),
          animation: screenController.controller,
          func: screenController.open,
          meditations: widget.menuContent.recentlyPlayed),
    ];

    return !menuOnTop
        ? Stack(
            children: [
              TitleContent(
                  safeAreaHeight:
                      ScreenProperties.of(context).screenValues.safeAreaHeight,
                  height:
                      ScreenProperties.of(context).screenValues.safeAreaHeight *
                          0.37,
                  width: ScreenProperties.of(context).screenValues.width,
                  menuContent: widget.menuContent,
                  animationController: screenController.controller),
              stackPosition ? favrec[1] : favrec[0],
              stackPosition ? favrec[0] : favrec[1],
            ],
          )
        : Stack(
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: (ScreenProperties.of(context)
                                  .screenValues
                                  .safeAreaHeight *
                              0.63) *
                          1.75,
                      color: Color.fromRGBO(6, 18, 113, 1.0),
                    ),
                    stackPosition ? favrec[1] : favrec[0],
                    stackPosition ? favrec[0] : favrec[1],
                  ],
                ),
              ),
              TitleContent(
                  safeAreaHeight:
                      ScreenProperties.of(context).screenValues.safeAreaHeight,
                  height:
                      ScreenProperties.of(context).screenValues.safeAreaHeight *
                          0.37,
                  width: ScreenProperties.of(context).screenValues.width,
                  menuContent: widget.menuContent,
                  animationController: zeroSeconds),
              BottomMenu(),
            ],
          );
  }
}
