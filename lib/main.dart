import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'screens/prayer_timing_screen.dart';
import 'screens/prayer_tracker_screen.dart';
import 'screens/qibla_screen.dart';
import 'screens/setting_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prayer App',
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        PrayerTrackerScreen.id: (context) => PrayerTrackerScreen(),
        PrayerTimingScreen.id: (context) => PrayerTimingScreen(),
        QiblaScreen.id: (context) => QiblaScreen(),
        SettingScreen.id: (context) => SettingScreen(),
      },
    );
  }
}
