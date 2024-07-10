
import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/menuScreen.dart';
import 'package:flutterdesignchallange_calmapp/menucomponents/favorites.dart';
import 'package:flutterdesignchallange_calmapp/menucomponents/recently_played.dart';

class ScreenController extends ChangeNotifier {
  final AnimationController controller;

  final TickerProvider vsync;

  ScreenController({required this.vsync})
      : controller = AnimationController(vsync: vsync) {
    controller
      ..duration = const Duration(milliseconds: 800)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.forward:
            break;
          case AnimationStatus.completed:
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.dismissed:
            var x = recentlyPlayedKey.currentState as RecentlyPlayedState;
            x.invertPage();
            var y = favoritesKey.currentState as FavoritesState;
            y.invertPage();
            print('called reversion');
            break;
        }
        notifyListeners();
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  get percentOpen {
    return controller.value;
  }

  open() {
    controller.forward();
  }

  close() {
    controller.reverse();
  }
}
