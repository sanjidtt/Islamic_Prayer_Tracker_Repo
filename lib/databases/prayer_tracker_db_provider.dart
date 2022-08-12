import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PrayerTrackerDbProvider {
  var tempPath;
  init() async {
    Directory prayerTrackerDbDir = await getApplicationDocumentsDirectory();
    tempPath = join(prayerTrackerDbDir.path, "prayertracker.db");
    Database prayerTrackerDb = await openDatabase(
      tempPath,
      version: 1,
      onCreate: (Database newDb, int version) async {
        newDb.execute("""
          CREATE TABLE PRAYER_TRACKER
            (
              Fajr INTEGER,
              Dhuhr INTEGER,
              Asr INTEGER,
              Maghrib INTEGER,
              Isha INTEGER,
              Tahajjud INTEGER,
              Date TEXT PRIMARY KEY
            )
        """);

        print('TABLE CREATION DONE');

        var datetime = DateTime.now().toString().split(new RegExp(r"[- ]"));
        int tempIntYear = int.parse(datetime[0]);
        String tempYear = datetime[0];
        String tempDay = datetime[2];
        String tempMonth = datetime[1];
        String todayDate = '';

        var tempMonthMap = {};

        if (tempIntYear % 4 == 0) {
          tempMonthMap = {
            1: 31,
            2: 29,
            3: 31,
            4: 30,
            5: 31,
            6: 30,
            7: 31,
            8: 31,
            9: 30,
            10: 31,
            11: 30,
            12: 31
          };
        } else {
          tempMonthMap = {
            1: 31,
            2: 28,
            3: 31,
            4: 30,
            5: 31,
            6: 30,
            7: 31,
            8: 31,
            9: 30,
            10: 31,
            11: 30,
            12: 31
          };
        }

        print('Preparing to Insert');

        for (int month = 1; month <= 12; month++) {
          int tempNum = tempMonthMap[month];
          for (int day = 1; day <= tempNum; day++) {
            todayDate = giveDate(day, month, tempYear);
            print(todayDate);
            await newDb.insert(
              "PRAYER_TRACKER",
              {
                'Fajr': 0,
                'Dhuhr': 0,
                'Asr': 0,
                'Maghrib': 0,
                'Isha': 0,
                'Tahajjud': 0,
                'Date': todayDate,
              },
            );
          }
        }
      },
    );
    print('_______Init Done________');
  }

  updatePrayerTracker(
      String tempPrayer, bool tempValue, String tempDate) async {
    Database tempdb = await openDatabase(tempPath);
    int numValue;
    if (tempValue) {
      numValue = 1;
    } else {
      numValue = 0;
    }

    print('Praparing to Update');

    await tempdb.rawUpdate(
        'UPDATE PRAYER_TRACKER SET $tempPrayer = ? WHERE Date = ?',
        [numValue.toString(), tempDate]);
  }

  fetchPrayerTracker(String date) async {
    Database tempdb = await openDatabase(tempPath);
    final tempTracker = tempdb.query(
      "PRAYER_TRACKER",
      columns: null,
      where: "Date = ?",
      whereArgs: [date],
    );

    print('_______Fetch Done 1________');

//    var tempRec = await tempdb.rawQuery('SELECT Fajr FROM PRAYER_TIMES');
//    print(tempRec.first['Fajr']);

    return tempTracker;
  }

  String giveDate(int tempDay, int tempMonth, String tempYear) {
    String varDay = '';
    String varMonth = '';
    if (tempDay < 10) {
      varDay = '0' + tempDay.toString();
    } else {
      varDay = tempDay.toString();
    }

    if (tempMonth < 10) {
      varMonth = '0' + tempMonth.toString();
    } else {
      varMonth = tempMonth.toString();
    }

    return varMonth + '-' + varDay + '-' + tempYear;
  }
}

PrayerTrackerDbProvider prayerTrackerDbObj = PrayerTrackerDbProvider();
