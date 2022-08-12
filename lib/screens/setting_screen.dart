import 'package:flutter/material.dart';
import 'package:prayer_app/resources/bottom_app_bar.dart';

class SettingScreen extends StatelessWidget {
  static String id = 'setting_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Text("Setting"),
      bottomNavigationBar: NewBottomNavBar(),
    );
  }
}
