import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:prayer_app/resources/bottom_app_bar.dart';

import '../databases/prayer_time_db_provider.dart';

class PrayerTimingScreen extends StatefulWidget {
  static String id = 'prayer_timing_screen';
  @override
  _PrayerTimingScreenState createState() => _PrayerTimingScreenState();
}

class _PrayerTimingScreenState extends State<PrayerTimingScreen> {
  /// Variables
  PrayerTimeDbProvider prayerDbObj = PrayerTimeDbProvider();
  var responseDecodeJson = null;
  String long = '';
  String lat = '';

  ///
  String fajrTime = '';
  String dhuhrTime = '';
  String asrTime = '';
  String magribTime = '';
  String ishaTime = '';
  String sunriseTime = '';
  String midnightTime = '';
  String lastThirdTime = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrayerTimes();
  }

  void getPrayerTimes() async {
    /// Variables
    var datetime = DateTime.now().toString().split(new RegExp(r"[- ]"));
    String tempDay = datetime[2];
    String tempMonth = datetime[1];
    String tempYear = datetime[0];
    String todayDate = tempDay + '-' + tempMonth + '-' + tempYear;
    //print(tempDay + '-' + tempMonth + '-' + tempYear);

    await prayerDbObj.init();
    print('Init_Done_2');

    var flagAPI = await prayerDbObj.willCallApi(todayDate);

    if (flagAPI) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      long = position.toString().split(new RegExp(r"[, ]"))[4];
      lat = position.toString().split(new RegExp(r"[, ]"))[1];

      String url =
          'https://api.aladhan.com/v1/calendar?latitude=$lat&longitude=$long&method=2&month=$tempMonth&year=$tempYear';

      Response response = await get(url);
      print('API Call Done');
      //print(jsonDecode(response.body)['data'][0]['date']['readable']);
      //print(jsonDecode(response.body)['data'].length);

      responseDecodeJson = jsonDecode(response.body);

      await prayerDbObj.addPrayerTime(responseDecodeJson);
      print('Add_Done_2');
    }

    var tempTimings = await prayerDbObj.fetchPrayerTime(todayDate);
    print('Fetch_Done_2');

    setState(() {
      fajrTime = tempTimings[0]['Fajr'];
      fajrTime = checkTime(fajrTime);
      sunriseTime = tempTimings[0]['Sunrise'];
      sunriseTime = checkTime(sunriseTime);
      dhuhrTime = tempTimings[0]['Dhuhr'];
      dhuhrTime = checkTime(dhuhrTime);
      asrTime = tempTimings[0]['Asr'];
      asrTime = checkTime(asrTime);
      magribTime = tempTimings[0]['Maghrib'];
      magribTime = checkTime(magribTime);
      ishaTime = tempTimings[0]['Isha'];
      ishaTime = checkTime(ishaTime);
      midnightTime = tempTimings[0]['Midnight'];
      midnightTime = checkTime(midnightTime);
      lastThirdTime = tempTimings[0]['Lastthird'];
      lastThirdTime = checkTime(lastThirdTime);
      //print(int.parse('05:09'));
    });
  }

  String checkTime(var tempTime) {
    var tempTime2 =
        (tempTime.split(new RegExp(r"[ ]"))[0]).split(new RegExp(r"[:]"));
    if (int.parse(tempTime2[0]) < 12) {
      if (int.parse(tempTime2[0]) == 0) {
        return '12' + ':' + tempTime2[1] + ' AM';
      }
      return tempTime2[0] + ':' + tempTime2[1] + ' AM';
    } else {
      if (int.parse(tempTime2[0]) == 12) {
        return '12' + ':' + tempTime2[1] + ' PM';
      }
      int tempNum = int.parse(tempTime2[0]) - 12;
      return '0' + tempNum.toString() + ':' + tempTime2[1] + ' PM';
    }
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
              child: SizedBox(),
            ),
            Expanded(
              flex: 680,
              child: Row(
                children: [
                  Expanded(
                    flex: 60,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 500,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0XFF19A883),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PrayerCards(
                            title: 'Fajr',
                            time: fajrTime,
                          ),
                          MyDivider(),
                          PrayerCards(
                            title: 'Sunrise',
                            time: sunriseTime,
                          ),
                          MyDivider(),
                          PrayerCards(
                            title: 'Dhuhr',
                            time: dhuhrTime,
                          ),
                          MyDivider(),
                          PrayerCards(
                            title: 'Asr',
                            time: asrTime,
                          ),
                          MyDivider(),
                          PrayerCards(
                            title: 'Magrib',
                            time: magribTime,
                          ),
                          MyDivider(),
                          PrayerCards(
                            title: 'Isha',
                            time: ishaTime,
                          ),
                          MyDivider(),
                          PrayerCards(
                            title: 'Midnight',
                            time: midnightTime,
                          ),
                          MyDivider(),
                          PrayerCards(
                            title: 'Last 1/3 Night',
                            time: lastThirdTime,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 60,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 30,
              child: SizedBox(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NewBottomNavBar(),
    );
  }
}

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      color: Colors.white70,
      indent: 25,
      endIndent: 25,
    );
  }
}

class PrayerCards extends StatelessWidget {
  final title;
  final time;
  PrayerCards({this.title, this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
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
          'Salah Time',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
