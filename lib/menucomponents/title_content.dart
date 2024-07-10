import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';
import 'package:flutterdesignchallange_calmapp/models.dart';

class TitleContent extends AnimatedWidget {
  final double width;
  final double height;
  final double safeAreaHeight;
  final ScreenElements menuContent;
  final AnimationController animationController;
  TitleContent({
    required this.width,
    required this.height,
    required this.menuContent,
    required this.animationController,
    required this.safeAreaHeight,
  }) : super(listenable: animationController);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: safeAreaHeight,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height,
            child: Column(
              children: [
                MountainsTitle(
                    safeAreaHeight: safeAreaHeight,
                    animationController: animationController,
                    height: height * 0.7,
                    width: width,
                    salutation: menuContent.salutataion,
                    name: menuContent.name,
                    icon: menuContent.icon),
                FeelingsQuestion(
                    animationController: animationController,
                    height: height * 0.3,
                    width: width,
                    question: menuContent.feelingsQuestion),
              ],
            ),
          ),
          Opacity(
            opacity: 0.0,
            child: Container(height: safeAreaHeight - height, width: width),
          ),
        ],
      ),
    );
  }
}

class MountainsTitle extends StatefulWidget {
  AnimationController animationController;
  double height;
  double width;
  String salutation;
  String name;
  Icon icon;
  double safeAreaHeight;

  MountainsTitle(
      {required this.animationController,
      required this.height,
      required this.width,
      required this.icon,
      required this.name,
      required this.safeAreaHeight,
      required this.salutation});

  @override
  _MountainsTitleState createState() => _MountainsTitleState();
}

class _MountainsTitleState extends State<MountainsTitle>
    with TickerProviderStateMixin {
  late CurvedAnimation _fadeOutAnimation;
  late AnimationController _fadeInAnimation;

  bool fadeIn = false;

  @override
  void initState() {
    super.initState();
    _fadeOutAnimation = CurvedAnimation(
        parent: widget.animationController, curve: Curves.fastOutSlowIn);

    _fadeInAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    _fadeInAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (this.mounted) {
          setState(() {
            fadeIn = false;
          });
        }
      }
    });

    widget.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (this.mounted) {
          setState(() {
            fadeIn = true;
            print('fadeInTrue');
            _fadeInAnimation.reset();
          });
        }
      }
      if (status == AnimationStatus.reverse) {
        _fadeInAnimation.forward();
      }
    });
    _fadeInAnimation.addListener(() {
      if (this.mounted) {
        setState(() {});
      }
    });
  }

   @override
  void dispose() {
    // TODO: implement dispose
    //widget.animationController.dispose();
    _fadeInAnimation.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(138, 132, 250, 1.0),
                  Color.fromRGBO(182, 154, 218, 1.0),
                  Color.fromRGBO(214, 178, 167, 1.0),
                ]),
          ),
          child: FractionalTranslation(
            translation: Offset(
              0.0,
              widget.animationController.value,
            ),
            child: Opacity(
              opacity: 0.6,
              child: CustomPaint(
                painter: MountainPainter(),
              ),
            ),
          ),
        ),
        Positioned(
          top: widget.safeAreaHeight * 0.03,
          left: !fadeIn
              ? widget.width * 0.05 -
                  lerpDouble(0.0, widget.width * 2, _fadeOutAnimation.value)!
              : (ScreenProperties.of(context).screenValues.width * 2 * -1) +
                  lerpDouble(0.0, widget.width * 2 + widget.width * 0.05,
                      _fadeInAnimation.value)!,
          child: Padding(
            padding: EdgeInsets.all(
                ScreenProperties.of(context).screenValues.value8),
            child: widget.icon,
          ),
        ),
        Positioned(
          bottom: widget.height * 0.22,
          left: !fadeIn
              ? widget.width * 0.05 -
                  lerpDouble(0.0, widget.width * 2, _fadeOutAnimation.value)!
              : (ScreenProperties.of(context).screenValues.width * 2 * -1) +
                  lerpDouble(0.0, widget.width * 2 + widget.width * 0.05,
                      _fadeInAnimation.value)!,
          child: Padding(
            padding: EdgeInsets.all(
                ScreenProperties.of(context).screenValues.value8),
            child: Text(
              widget.salutation,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ScreenProperties.of(context).screenValues.value16,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: !fadeIn
              ? widget.width * 0.05 -
                  lerpDouble(0.0, widget.width * 2, _fadeOutAnimation.value)!
              : (ScreenProperties.of(context).screenValues.width * 2 * -1) +
                  lerpDouble(0.0, widget.width * 2 + widget.width * 0.05,
                      _fadeInAnimation.value)!,
          child: Padding(
            padding: EdgeInsets.all(
                ScreenProperties.of(context).screenValues.value8),
            child: Text(
              widget.name,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ScreenProperties.of(context).screenValues.value32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: widget.safeAreaHeight * 0.03,
          right: widget.width * 0.05 -
              lerpDouble(0.0, widget.width * 2, _fadeOutAnimation.value)!,
          child: Padding(
            padding: EdgeInsets.all(
                ScreenProperties.of(context).screenValues.value8),
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ),
        Opacity(
          opacity: widget.animationController.value,
          child: Container(
            width: double.infinity,
            height: widget.height,
            color: Color.fromRGBO(6, 18, 113, 1.0),
          ),
        )
      ],
    );
  }
}

class MountainPainter extends CustomPainter {
  final paint1 = Paint()
    ..style = PaintingStyle.fill
    ..color = Color.fromRGBO(67, 65, 190, 1.0);
  final paint2 = Paint()
    ..style = PaintingStyle.fill
    ..color = Color.fromRGBO(21, 42, 144, 1.0);

  final paint3 = Paint()
    ..style = PaintingStyle.fill
    ..color = Color.fromRGBO(28, 49, 172, 1.0);

  final paint4 = Paint()
    ..style = PaintingStyle.fill
    ..color = Color.fromRGBO(22, 39, 149, 1.0);

  final paint5 = Paint()
    ..style = PaintingStyle.fill
    ..color = Color.fromRGBO(14, 32, 128, 1.0);

  @override
  void paint(Canvas canvas, Size size) {
    final mountain1 = Path();
    mountain1.moveTo(size.width * 0.05, size.height);
    mountain1.cubicTo(size.width * 0.25, size.height * 0.5, size.width * 0.75,
        size.height, size.width * 0.75, size.height);
    mountain1.close();
    canvas.drawPath(mountain1, paint1);

    final mountain11 = Path();
    mountain11.moveTo(size.width * 0.15, size.height * 0.9);
    mountain11.cubicTo(size.width * 0.3, size.height * 0.3, size.width * 0.5,
        size.height, size.width * 0.5, size.height);
    mountain11.close();
    canvas.drawPath(mountain11, paint1);

    final mountain2 = Path();
    mountain2.moveTo(size.width * 0.2, size.height);
    mountain2.cubicTo(size.width * 0.4, size.height * 0.2, size.width * 0.7,
        size.height * 0.2, size.width, size.height);
    mountain2.close();
    canvas.drawPath(mountain2, paint2);

    final mountain22 = Path();
    mountain22.moveTo(size.width * 0.28, size.height);
    mountain22.cubicTo(size.width * 0.6, 0.0, size.width * 0.8, 0.0,
        size.width * 1.2, size.height * 0.9);
    mountain22.close();
    canvas.drawPath(mountain22, paint2);

    final mountain3 = Path();
    mountain3.moveTo(size.width * 0.45, size.height);
    mountain3.cubicTo(size.width * 0.8, size.height * 0.5, size.width * 0.9,
        size.height * 0.5, size.width * 1.5, size.height);
    mountain3.close();
    canvas.drawPath(mountain3, paint3);

    final mountain4 = Path();
    mountain4.moveTo(size.width * 0.55, size.height);
    mountain4.cubicTo(size.width * 0.8, size.height * 0.75, size.width * 0.9,
        size.height * 0.75, size.width, size.height);
    mountain4.close();
    canvas.drawPath(mountain4, paint4);

    final mountain5 = Path();
    mountain5.moveTo(size.width * 0.8, size.height);
    mountain5.cubicTo(size.width * 0.9, size.height * 0.8, size.width,
        size.height * 0.8, size.width * 1.3, size.height);
    mountain5.close();
    canvas.drawPath(mountain5, paint5);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class FeelingsQuestion extends StatefulWidget {
  AnimationController animationController;
  double height;
  double width;
  String question;
  FeelingsQuestion({
    required this.animationController,
    required this.height,
    required this.width,
    required this.question,
  });

  @override
  _FeelingsQuestionState createState() => _FeelingsQuestionState();
}

class _FeelingsQuestionState extends State<FeelingsQuestion>
    with TickerProviderStateMixin {
  late CurvedAnimation _fadeOutAnimation;
  late AnimationController _fadeInAnimation;
  bool fadeIn = false;

  @override
  void initState() {
    super.initState();
    _fadeOutAnimation = CurvedAnimation(
        parent: widget.animationController, curve: Curves.fastOutSlowIn);

    _fadeInAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    _fadeInAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (this.mounted) {
          setState(() {
            fadeIn = false;
          });
        }
      }
    });

    widget.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (this.mounted) {
          setState(() {
            fadeIn = true;
            print('fadeInTrue');
            _fadeInAnimation.reset();
          });
        }
      }
      if (status == AnimationStatus.reverse) {
        _fadeInAnimation.forward();
      }
    });
    _fadeInAnimation.addListener(() {
      if (this.mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //widget.animationController.dispose();
    _fadeInAnimation.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(39, 62, 178, 1.0),
                Color.fromRGBO(6, 18, 113, 1.0)
              ]),
        ),
        child: Stack(
          children: [
            Positioned(
              top: widget.height * 0.1,
              bottom: widget.height * 0.1,
              left: !fadeIn
                  ? widget.width * 0.05 -
                      lerpDouble(0.0, widget.width * 2, _fadeOutAnimation.value)!
                  : (ScreenProperties.of(context).screenValues.width * 2 * -1) +
                      lerpDouble(0.0, widget.width * 2 + widget.width * 0.05,
                          _fadeInAnimation.value)!,
              child: Container(
                width: widget.width * 0.8,
                height: widget.height * 0.8,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 52, 157, 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: ' 😊   How are you feeling?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ScreenProperties.of(context)
                                .screenValues
                                .value16,
                          ), // non-emoji characters
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Opacity(
        opacity: widget.animationController.value,
        child: Container(
          width: double.infinity,
          height: widget.height,
          color: Color.fromRGBO(6, 18, 113, 1.0),
        ),
      ),
    ]);
  }
}
