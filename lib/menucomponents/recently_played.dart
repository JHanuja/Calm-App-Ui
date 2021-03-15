
import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/contentScreen.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';
import 'package:flutterdesignchallange_calmapp/menuScreen.dart';


GlobalKey recentlyPlayedKey = GlobalKey(debugLabel: 'RecentlyPlayed');
List<GlobalKey> recentlyImagesKeyList = [];


class RecentlyPlayed extends StatefulWidget {
  double completeScreenHeight;
  double width;
  double height;
  List<Meditation> meditations;
  Color color;
  dynamic func;
  Animation animation;
  double safeAreaHeight;
  double heightParentTop;
  double heightParentBottom;
  double imageTargetHeight;

  RecentlyPlayed(
      {this.width,
      this.height,
      this.meditations,
      this.color,
      this.func,
      this.safeAreaHeight,
      this.heightParentTop,
      this.heightParentBottom,
      this.completeScreenHeight,
      this.animation,
      this.imageTargetHeight})
      : super(key: recentlyPlayedKey);

  @override
  RecentlyPlayedState createState() => RecentlyPlayedState();
}

class RecentlyPlayedState extends State<RecentlyPlayed> {
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

  scaleImage(String newImagePath, int keyIndex) {
    var x = menuScreenKey.currentState as MenuScreenState;
    x.changeStackPosition(false);

    RenderBox renderBox =
        recentlyImagesKeyList[keyIndex].currentContext.findRenderObject();

    setState(() {
      meditation = recentlyPlayed[keyIndex];
      imageX = (renderBox.localToGlobal(Offset(0.0, 0.0)).dx);
      imageY = (renderBox.localToGlobal(Offset(0.0, 0.0)).dy);
      imageWidth = (renderBox.size.width);
      imageHeight = (renderBox.size.height);
      imagePath = newImagePath;
      content = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                      height: widget.heightParentTop, width: widget.width)),
              Opacity(
                opacity: 1.0,
                child: Container(
                  height: widget.height,
                  width: widget.width,
                  color: widget.color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenProperties.of(context).screenValues.value16,
                            ScreenProperties.of(context).screenValues.value16,
                            0.0,
                            0.0),
                        child: Text(
                          'Recently Played',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ScreenProperties.of(context)
                                .screenValues
                                .value16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.meditations.length,
                            itemBuilder: (BuildContext context, int index) {
                              recentlyImagesKeyList
                                  .add(GlobalKey(debugLabel: index.toString()));
                              return MeditationCardVertical(
                                index: index,
                                func: widget.func,
                                height: widget.height * 0.8,
                                width: widget.width * 0.4,
                                meditation: widget.meditations[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                  opacity: 0.0,
                  child: Container(
                      height: widget.heightParentBottom, width: widget.width)),
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
    /* 
          */
  }
}

class MeditationCardVertical extends StatefulWidget {
  double height;
  int index;
  double width;
  Meditation meditation;
  dynamic func;

  MeditationCardVertical({
    this.height,
    this.index,
    this.width,
    this.meditation,
    this.func,
  });

  @override
  _MeditationCardVerticalState createState() => _MeditationCardVerticalState();
}

class _MeditationCardVerticalState extends State<MeditationCardVertical> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.func();
        print(widget.meditation.imagePath);
        (recentlyPlayedKey.currentState as RecentlyPlayedState)
            .scaleImage(widget.meditation.imagePath, widget.index);
      },
      child: Padding(
        padding:
            EdgeInsets.all(ScreenProperties.of(context).screenValues.value16),
        child: Stack(
          children: [
            ListItemImageVertical(
                index: widget.index,
                height: widget.height,
                width: widget.width,
                imagePath: widget.meditation.imagePath),
            Positioned(
              bottom: widget.height * 0.35,
              left: widget.width * 0.05,
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(
                        ScreenProperties.of(context).screenValues.value8 / 2),
                    child: Text(
                      widget.meditation.contentType,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: ScreenProperties.of(context)
                              .screenValues
                              .value12),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(115, 109, 169, 1.0),
                      borderRadius: BorderRadius.circular(16.0)),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: widget.height * 0.3,
                width: widget.width,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 52, 157, 1.0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                      child: Text(
                        widget.meditation.name,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: ScreenProperties.of(context)
                                .screenValues
                                .value16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          ScreenProperties.of(context).screenValues.value8,
                          0.0,
                          0.0,
                          0.0),
                      child: Text(
                        widget.meditation.duration,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: ScreenProperties.of(context)
                                .screenValues
                                .value12),
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



class ListItemImageVertical extends StatelessWidget {
  double width;
  double height;
  String imagePath;
  int index;

  ListItemImageVertical({this.width, this.height, this.imagePath, this.index})
      : super(key: recentlyImagesKeyList[index]);

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