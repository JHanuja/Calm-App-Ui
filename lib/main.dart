import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/helper.dart';
import 'package:flutterdesignchallange_calmapp/menuScreen.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          var width = MediaQuery.of(context).size.width;
          ScreenValues values = ScreenValues(
              completeScreenHeight: MediaQuery.of(context).size.height,
              safeAreaHeight: constraints.maxHeight,
              width: width,
              value8: width * 0.022,
              value16: width * 0.044,
              value12: width * 0.033,
              value32: width * 0.088);

          return Scaffold(
            body: ScreenProperties(
              screenValues: values,
              child:  MenuScreen(
              menuContent: menuContentHomeScreen,
            ),
            ),
          );
        }),
      ),
    );
  }
}

class ScreenProperties extends InheritedWidget {
  ScreenValues screenValues;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  ScreenProperties({this.screenValues, Widget child}) : super(child: child);

  static ScreenProperties of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: ScreenProperties);
}
