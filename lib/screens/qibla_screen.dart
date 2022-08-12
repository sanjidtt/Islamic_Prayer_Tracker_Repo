import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

import '../resources/bottom_app_bar.dart';

class QiblaScreen extends StatefulWidget {
  static String id = 'qibla_screen';
  @override
  _QiblaScreenState createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  double? directionAngle = 0;
  String qiblaText = 'Initialising';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        directionAngle = event.heading;

//        if (directionAngle! > -84 && directionAngle! <= 0) {
//          qiblaText = 'Turn Left';
//        } else if (directionAngle! > 0 && directionAngle! <= 97) {
//          qiblaText = 'Turn Left';
//        } else if (directionAngle! > 97 && directionAngle! <= 180) {
//          qiblaText = 'Turn Right';
//        } else if (directionAngle! > -180 && directionAngle! < -80) {
//          qiblaText = 'Turn Right';
//        } else if (directionAngle! >= -80 && directionAngle! <= -84) {
//          qiblaText = 'Eureka';
//        }
        if (directionAngle! + 82.43 < -5) {
          qiblaText = 'Turn Right';
        } else if (directionAngle! + 82.43 > 5) {
          qiblaText = 'Turn Left';
        } else {
          qiblaText = 'Eureka';
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlutterCompass.events!.drain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 100,
              child: MyAppBar(),
            ),
            Expanded(
              flex: 30,
              child: Placeholder(),
            ),
            Expanded(
              flex: 200,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Placeholder(),
                  ),
                  Expanded(
                    flex: 50,
                    child: TextCard(tempText: qiblaText),
                  ),
                  Expanded(
                    flex: 6,
                    child: Placeholder(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 30,
              child: Placeholder(),
            ),
            Expanded(
              flex: 450,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CompassBG(),
                  Transform.rotate(
                    angle: (pi / 180) * -directionAngle!,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      //color: Color(0XFF37B899),
                      //height: 400,
                      child: Image.asset(
                        "images/new_pic.png",
                        height: MediaQuery.of(context).size.width * (54 / 62),
                        width: MediaQuery.of(context).size.width * (54 / 62),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: (pi / 180) * -(directionAngle! + 82.43),
                    child: Container(
                      //color: Colors.blue,
                      //height: 400,
                      child: Image.asset(
                        "images/kaaba.png",
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 30,
              child: Placeholder(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NewBottomNavBar(),
    );
  }
}

class CompassBG extends StatelessWidget {
  const CompassBG({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF37B899),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: MediaQuery.of(context).size.width * (54 / 62),
      height: MediaQuery.of(context).size.width * (54 / 62),
    );
  }
}

class TextCard extends StatelessWidget {
  final String tempText;
  TextCard({required this.tempText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF37B899),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: AutoSizeText(
          tempText,
          maxLines: 1,
          maxFontSize: 36,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
            fontFamily: 'BebasNeue',
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFF37B899),
      width: double.infinity,
      child: Center(
        child: Text(
          'Qibla Direction',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
