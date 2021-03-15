import 'package:flutter/material.dart';

class ScreenElements {
  String salutataion;
  String name;
  Icon icon;
  String feelingsQuestion;
  List<Meditation> recentlyPlayed;
  List<Meditation> favorites;
  ScreenElements(
      {this.salutataion,
      this.name,
      this.icon,
      this.feelingsQuestion,
      this.recentlyPlayed,
      this.favorites});
}

class Meditation {
  String name;
  String contentType;
  String imagePath;
  String duration;
  String text;
  int currentSong;
  List<PlayListItem> playlist;
  Meditation(
      {this.name,
      this.contentType,
      this.imagePath,
      this.duration,
      this.currentSong,
      this.text,
      this.playlist});
}

class PlayListItem {
  String name;
  String description;
  double secondsTotal;
  String imagePath;
  int minutes;
  int seconds;
  double secondsPlayed;

  PlayListItem(
      {this.name,
      this.description,
      this.secondsPlayed,
      this.minutes,
      this.seconds,
      this.secondsTotal,
      this.imagePath});
}

final List<PlayListItem> meditationPlaylist = [
  PlayListItem(
      name: 'Ocean sounds',
      description: 'Quiet',
      secondsTotal: 200.0,
      minutes: 3,
      seconds: 20,
      secondsPlayed: 90.0,
      imagePath: 'assets/oceansounds.jpg'),
  PlayListItem(
      name: 'Sunset',
      description: 'Happy',
      secondsTotal: 300.0,
      minutes: 5,
      seconds: 0,
      secondsPlayed: 100.0,
      imagePath: 'assets/sunset.jpg'),
  PlayListItem(
      name: 'Sunrise',
      description: 'Relaxed',
      secondsTotal: 150.0,
      minutes: 2,
      seconds: 30,
      secondsPlayed: 80.0,
      imagePath: 'assets/sunrise.jpg'),
  PlayListItem(
      name: 'Climb',
      description: 'Relaxed',
      secondsPlayed: 70.0,
      secondsTotal: 230.0,
      minutes: 3,
      seconds: 50,
      imagePath: 'assets/mountain.jpg'),
];

final List<Meditation> recentlyPlayed = [
  Meditation(
      playlist: meditationPlaylist,
      currentSong: 0,
      name: 'Daily Calm',
      contentType: 'Meditation',
      duration: '10 min',
      imagePath: 'assets/lakewithtree.jpg',
      text:
          'This meditation list is largely focused \non accepting what is happening to your \nmindset, and developing an awareness \nthat helps us to let go of negative emotions.'),
  Meditation(
      playlist: meditationPlaylist,
      currentSong: 1,
      name: 'Stay happy',
      contentType: 'Sleep',
      duration: '10 min',
      imagePath: 'assets/rockscoast.jpg',
      text:
          'This meditation list is largely focused \non accepting what is happening to your \nmindset, and developing an awareness\nthat helps us to let go of negative emotions.'),
];

final List<Meditation> favorites = [
  Meditation(
      playlist: meditationPlaylist,
      currentSong: 2,
      name: 'Train your mind',
      contentType: 'Meditation',
      duration: '10 min',
      imagePath: 'assets/meditaterock.jpg',
      text:
          'This meditation list is largely focused \non accepting what is happening to your \nmindset, and developing an awareness \nthat helps us to let go of negative emotions.'),
  Meditation(
      playlist: meditationPlaylist,
      currentSong: 3,
      name: '7 Chakras',
      contentType: 'Meditation',
      duration: '10 min',
      imagePath: 'assets/coastline.jpg',
      text:
          'This meditation list is largely focused \non accepting what is happening to your \nmindset, and developing an awareness \nthat helps us to let go of negative emotions.'),
];

final menuContentHomeScreen = ScreenElements(
    salutataion: 'Good afternoon,',
    name: 'Jessica',
    icon: Icon(
      Icons.face,
      color: Colors.yellow,
    ),
    feelingsQuestion: 'How are you feeling?',
    favorites: favorites,
    recentlyPlayed: recentlyPlayed);
