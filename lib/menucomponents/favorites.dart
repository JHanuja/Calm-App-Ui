

import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/contentScreen.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';
import 'package:flutterdesignchallange_calmapp/menuScreen.dart';


GlobalKey favoritesKey = GlobalKey(debugLabel: 'Favorites');
List<GlobalKey> favoritesImagesKeyList = [];


class Favorites extends StatefulWidget {
  List<Meditation> meditations;
  double height;
  double width;
  Animation animation;
  double safeAreaHeight;
  double heightParentMiddle;
  double heightParentTop;
  Color color;
  dynamic func;
  double imageTargetHeight;
  double completeScreenHeight;

  Favorites(
      {this.meditations,
      this.height,
      this.width,
      this.animation,
      this.safeAreaHeight,
      this.heightParentMiddle,
      this.color,
      this.heightParentTop,
      this.func,
      this.imageTargetHeight,
      this.completeScreenHeight})
      : super(key: favoritesKey);

  @override
  FavoritesState createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  bool content = false;
  String imagePath;
  double imageWidth;
  double imageHeight;
  double imageX;
  double imageY;
  Meditation meditation;

  invertPage() {
    setState(() {
      content = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  scaleImage(String newImagePath, int keyIndex) {
    var x = menuScreenKey.currentState as MenuScreenState;
    x.changeStackPosition(true);

    RenderBox renderBox =
        favoritesImagesKeyList[keyIndex].currentContext.findRenderObject();

    setState(() {
      meditation = favorites[keyIndex];
      imageX = (renderBox.localToGlobal(Offset(0.0, 0.0)).dx);
      imageY = (renderBox.localToGlobal(Offset(0.0, 0.0)).dy);
      imageWidth = (renderBox.size.width);
      imageHeight = (renderBox.size.height);
      imagePath = newImagePath;
      content = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.safeAreaHeight,
          width: widget.width,
          child: Column(
            children: [
              Opacity(
                opacity: 0.0,
                child: Container(
                  height: widget.heightParentTop,
                  width: widget.width,
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Container(
                  height: widget.heightParentMiddle,
                  width: widget.width,
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: widget.animation.value == 0 ? 1.0 : 0.0,
                  child: Container(
                    color: widget.color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                ScreenProperties.of(context)
                                    .screenValues
                                    .value16,
                                ScreenProperties.of(context)
                                    .screenValues
                                    .value16,
                                0.0,
                                0.0),
                            child: Container(
                                child: Stack(
                              children: [
                                Positioned(
                                  left: 0.0,
                                  child: Text(
                                    'Your Favorites',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ScreenProperties.of(context)
                                            .screenValues
                                            .value16,
                                        color: Colors.white),
                                  ),
                                ),
                                Positioned(
                                  right: ScreenProperties.of(context)
                                          .screenValues
                                          .width *
                                      0.05,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                          ),
                        ),
                        Container(
                          height: widget.height * 0.7,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                ScreenProperties.of(context)
                                    .screenValues
                                    .value16,
                                0.0,
                                0.0,
                                ScreenProperties.of(context)
                                    .screenValues
                                    .value16),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.meditations.length,
                              itemBuilder: (BuildContext context, int index) {
                                favoritesImagesKeyList.add(
                                    GlobalKey(debugLabel: index.toString()));
                                return MeditationCardHorizontal(
                                  index: index,
                                  func: widget.func,
                                  height: widget.height * 0.6,
                                  width: widget.width * 0.7,
                                  meditation: widget.meditations[index],
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        content
            ? ContentScreen(
                meditation: meditation,
                heightParentTop: widget.heightParentTop,
                width: widget.width,
                height: widget.height,
                imageTargetHeight: widget.imageTargetHeight,
                completeScreenHeight: widget.completeScreenHeight,
                safeAreaHeight: widget.safeAreaHeight,
                imagePath: imagePath,
                animation: widget.animation,
                imageHeight: imageHeight,
                imageWidth: imageWidth,
                imageX: imageX,
                imageY: imageY,
              )
            : Container()
      ],
    );
  }
}

class MeditationCardHorizontal extends StatefulWidget {
  double height;
  double width;
  Meditation meditation;
  int index;
  dynamic func;

  MeditationCardHorizontal(
      {this.height, this.width, this.meditation, this.index, this.func});

  @override
  _MeditationCardHorizontalState createState() =>
      _MeditationCardHorizontalState();
}

class _MeditationCardHorizontalState extends State<MeditationCardHorizontal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        widget.func();
        print(widget.meditation.imagePath);
        (favoritesKey.currentState as FavoritesState)
            .scaleImage(widget.meditation.imagePath, widget.index);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            0.0,
            ScreenProperties.of(context).screenValues.value8,
            ScreenProperties.of(context).screenValues.value16,
            ScreenProperties.of(context).screenValues.value16),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(33, 52, 157, 1.0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(
                      ScreenProperties.of(context).screenValues.value8),
                  child: ListItemImageHorizontal(
                      index: widget.index,
                      height: widget.height,
                      width: widget.width * 0.3,
                      imagePath: widget.meditation.imagePath)),
              Expanded(
                child: Container(
                  width: widget.width * 0.7,
                  height: widget.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.meditation.name,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ScreenProperties.of(context)
                                .screenValues
                                .value16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Container(
                          width: widget.width * 0.7,
                          height: widget.height * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
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
                              SizedBox(
                                width: widget.width * 0.1,
                              ),
                              Text(widget.meditation.duration,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItemImageHorizontal extends StatelessWidget {
  double width;
  double height;
  String imagePath;
  int index;

  ListItemImageHorizontal({this.width, this.height, this.imagePath, this.index})
      : super(key: favoritesImagesKeyList[index]);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                imagePath,
              )),
        ),
      ),
    );
  }
}