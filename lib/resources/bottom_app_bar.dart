import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer_app/blocs/bottom_app_bar_bloc.dart';
import 'package:prayer_app/screens/home_screen.dart';
import 'package:prayer_app/screens/prayer_timing_screen.dart';
import 'package:prayer_app/screens/prayer_tracker_screen.dart';
import 'package:prayer_app/screens/qibla_screen.dart';
import 'package:prayer_app/screens/setting_screen.dart';

class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  final screens = [
    HomeScreen.id,
    PrayerTrackerScreen.id,
    PrayerTimingScreen.id,
    QiblaScreen.id,
    SettingScreen.id
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: curInd,
      onTap: (index) => setState(() {
        curInd = index;
        Navigator.pushNamed(context, screens[curInd]);
      }),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color(0XFF37B899),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: 'Salah Tracker',
          backgroundColor: Color(0XFF37B899),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: 'Salah Time',
          backgroundColor: Color(0XFF37B899),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Qibla',
          backgroundColor: Color(0XFF37B899),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Color(0XFF37B899),
        ),
      ],
    );
  }
}

class NewBottomNavBar extends StatefulWidget {
  @override
  _NewBottomNavBarState createState() => _NewBottomNavBarState();
}

class _NewBottomNavBarState extends State<NewBottomNavBar> {
  final screens = [
    HomeScreen.id,
    PrayerTrackerScreen.id,
    PrayerTimingScreen.id,
    QiblaScreen.id,
    SettingScreen.id
  ];
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: [
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.checklist,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.access_time,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          FontAwesomeIcons.kaaba,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.settings,
          size: 30,
          color: Colors.white,
        ),
      ],
      height: 55,
      index: curInd,
      onTap: (index) => setState(() {
        curInd = index;
        Navigator.pushNamed(context, screens[curInd]);
      }),
      backgroundColor: Colors.transparent,
      color: Color(0XFF37B899),
      buttonBackgroundColor: Color(0XFF37B899),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 300),
    );
  }
}
