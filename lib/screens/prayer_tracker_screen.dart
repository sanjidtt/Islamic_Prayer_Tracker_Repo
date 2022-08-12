import 'package:flutter/material.dart';
import 'package:prayer_app/resources/bottom_app_bar.dart';
import 'package:prayer_app/screens/prayer_tracker_daily_screen.dart';
import 'package:prayer_app/screens/prayer_tracker_stat_screen.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class PrayerTrackerScreen extends StatefulWidget {
  static String id = 'prayer_tracker_screen';
  @override
  _PrayerTrackerScreenState createState() => _PrayerTrackerScreenState();
}

class _PrayerTrackerScreenState extends State<PrayerTrackerScreen> {
  int tempInd = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
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
                flex: 100,
                child: Material(
                  borderRadius: BorderRadius.circular(20),

                  //surfaceTintColor: Colors.deepPurple,
                  color: Colors.grey[200],
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        tempInd = index;
                      });
                    },
                    indicatorColor: Color(0XFF37B899),
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      //color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Oswald',
                    ),
                    unselectedLabelStyle: TextStyle(
                      //color: Colors.green,
                      fontSize: 24,
                      fontFamily: 'Oswald',
                    ),
                    //indicatorSize: TabBarIndicatorSize,
                    tabs: [
                      Tab(
                        text: 'Daily',
                      ),
                      Tab(
                        text: 'Statistics',
                      ),
                    ],

                    indicator: RectangularIndicator(
                      color: Color(0XFF37B899),
                      bottomLeftRadius: tempInd == 0 ? 20 : 0,
                      bottomRightRadius: tempInd == 0 ? 0 : 20,
                      topLeftRadius: tempInd == 0 ? 20 : 0,
                      topRightRadius: tempInd == 0 ? 0 : 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 610,
                child: TabBarView(
                  children: [
                    PrayerTrackerDailyScreen(),
                    PrayerTrackerStatScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NewBottomNavBar(),
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
          'Salah Tracker',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
