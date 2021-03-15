import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdesignchallange_calmapp/main.dart';

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: ScreenProperties.of(context).screenValues.value8 / 20,
        child: Container(
          height:
              ScreenProperties.of(context).screenValues.safeAreaHeight * 0.15,
          width: ScreenProperties.of(context).screenValues.width,
          child: Padding(
              padding: EdgeInsets.all(
                  ScreenProperties.of(context).screenValues.value16),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(1, 12, 72, 1.0),
                  borderRadius: BorderRadius.circular(90.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.access_time,
                          color: Colors.white60,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.beach_access,
                          color: Colors.white60,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.headset_mic,
                          color: Colors.white60,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
