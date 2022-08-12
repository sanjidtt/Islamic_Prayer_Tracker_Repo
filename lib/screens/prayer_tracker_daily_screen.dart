import 'package:flutter/material.dart';

import '../blocs/bottom_app_bar_bloc.dart';
import '../databases/prayer_tracker_db_provider.dart';

class PrayerTrackerDailyScreen extends StatefulWidget {
  @override
  _PrayerTrackerDailyScreenState createState() =>
      _PrayerTrackerDailyScreenState();
}

class _PrayerTrackerDailyScreenState extends State<PrayerTrackerDailyScreen> {
  final fajrCheckBoxState = CheckBoxState(tempTitle: 'Fajr');
  final dhuhrCheckBoxState = CheckBoxState(tempTitle: 'Dhuhr');
  final asrCheckBoxState = CheckBoxState(tempTitle: 'Asr');
  final magribCheckBoxState = CheckBoxState(tempTitle: 'Maghrib');
  final ishaCheckBoxState = CheckBoxState(tempTitle: 'Isha');

  getData() async {
    await prayerTrackerDbObj.init();

    /// Date Retrival
    var datetime = DateTime.now().toString().split(new RegExp(r"[- ]"));
    String tempDay = datetime[2];
    String tempMonth = datetime[1];
    String tempYear = datetime[0];
    String todayDate = tempDay + '-' + tempMonth + '-' + tempYear;
    var prayerTrackerData =
        await prayerTrackerDbObj.fetchPrayerTracker(todayDate);
    print(prayerTrackerData);
    setState(() {
      fajrCheckBoxState.tempValue =
          prayerTrackerData[0]['Fajr'] == 0 ? false : true;
      dhuhrCheckBoxState.tempValue =
          prayerTrackerData[0]['Dhuhr'] == 0 ? false : true;
      asrCheckBoxState.tempValue =
          prayerTrackerData[0]['Asr'] == 0 ? false : true;
      magribCheckBoxState.tempValue =
          prayerTrackerData[0]['Maghrib'] == 0 ? false : true;
      ishaCheckBoxState.tempValue =
          prayerTrackerData[0]['Isha'] == 0 ? false : true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 30,
            child: SizedBox(),
          ),
          Expanded(
            flex: 550,
            child: Row(
              children: [
                Expanded(
                  flex: 60,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cardCheckBoxTile(fajrCheckBoxState),
                      cardCheckBoxTile(dhuhrCheckBoxState),
                      cardCheckBoxTile(asrCheckBoxState),
                      cardCheckBoxTile(magribCheckBoxState),
                      cardCheckBoxTile(ishaCheckBoxState),
                    ],
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
    );
  }

  Container cardCheckBoxTile(CheckBoxState tempCheckBoxState) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 3,
          color: Color(0XFFBFBFBF),
        ),
      ),
      child: CheckboxListTile(
          shape: CircleBorder(),
          checkboxShape: CircleBorder(),
          value: tempCheckBoxState.tempValue,
          activeColor: Color(0XFF37B899),
          checkColor: Color(0XFF37B899),
          //selectedTileColor: Color(0XFF37B899),
          //dense: true,
          title: Text(tempCheckBoxState.tempTitle),
          onChanged: (value) {
            return setState(() {
              tempCheckBoxState.tempValue = value!;
              print(tempCheckBoxState.tempTitle);
              print(tempCheckBoxState.tempValue);

              /// Date Retrival
              var datetime =
                  DateTime.now().toString().split(new RegExp(r"[- ]"));
              String tempDay = datetime[2];
              String tempMonth = datetime[1];
              String tempYear = datetime[0];
              String todayDate = tempDay + '-' + tempMonth + '-' + tempYear;

              prayerTrackerDbObj.updatePrayerTracker(
                  tempCheckBoxState.tempTitle,
                  tempCheckBoxState.tempValue,
                  todayDate);

//              var prayerTrackerData =
//                  await prayerTrackerDbObj.fetchPrayerTracker(todayDate);
//              print(prayerTrackerData);
            });
          }),
    );
  }
}
