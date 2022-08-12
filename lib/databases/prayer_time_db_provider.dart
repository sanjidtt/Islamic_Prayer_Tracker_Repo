import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PrayerTimeDbProvider {
  var tempPath;
  init() async {
    Directory prayerDbDir = await getApplicationDocumentsDirectory();
    tempPath = join(prayerDbDir.path, "prayertime.db");
    Database prayerTimeDb = await openDatabase(
      tempPath,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE PRAYER_TIMES
            (
              Fajr TEXT,
              Sunrise TEXT,
              Dhuhr TEXT,
              Asr TEXT,
              Sunset TEXT,
              Maghrib TEXT,
              Isha TEXT,
              Imsak TEXT,
              Midnight TEXT,
              Firstthird TEXT,
              Lastthird TEXT,
              Gregorian_Date TEXT PRIMARY KEY,
              Hijri_Date TEXT
            )
        """);
      },
    );
    print('_______Init Done________');
  }

  fetchPrayerTime(String date) async {
    Database tempdb = await openDatabase(tempPath);
    final tempTime = tempdb.query(
      "PRAYER_TIMES",
      columns: null,
      where: "Gregorian_Date = ?",
      whereArgs: [date],
    );

    print('_______Fetch Done 1________');

    var tempRec = await tempdb.rawQuery('SELECT Fajr FROM PRAYER_TIMES');
    print(tempRec.first['Fajr']);

    return tempTime;
  }

  addPrayerTime(var tempJsonDecode) async {
    Database tempdb = await openDatabase(tempPath);

    int tempLen = tempJsonDecode['data'].length;
    for (int ind = 0; ind < tempLen; ind++) {
      await tempdb.insert(
        "PRAYER_TIMES",
        {
          'Fajr': tempJsonDecode['data'][ind]['timings']['Fajr'],
          'Sunrise': tempJsonDecode['data'][ind]['timings']['Sunrise'],
          'Dhuhr': tempJsonDecode['data'][ind]['timings']['Dhuhr'],
          'Asr': tempJsonDecode['data'][ind]['timings']['Asr'],
          'Sunset': tempJsonDecode['data'][ind]['timings']['Sunset'],
          'Maghrib': tempJsonDecode['data'][ind]['timings']['Maghrib'],
          'Isha': tempJsonDecode['data'][ind]['timings']['Isha'],
          'Imsak': tempJsonDecode['data'][ind]['timings']['Imsak'],
          'Midnight': tempJsonDecode['data'][ind]['timings']['Midnight'],
          'Firstthird': tempJsonDecode['data'][ind]['timings']['Firstthird'],
          'Lastthird': tempJsonDecode['data'][ind]['timings']['Lastthird'],
          'Gregorian_Date': tempJsonDecode['data'][ind]['date']['gregorian']
              ['date'],
          'Hijri_Date': tempJsonDecode['data'][ind]['date']['hijri']['date'],
        },
      );
    }
    print('_______Add Done 1________');
    var count = await tempdb.rawQuery('SELECT COUNT(*) FROM PRAYER_TIMES');
    print(count);
  }

  willCallApi(String tempDate) async {
    Database tempdb = await openDatabase(tempPath);
    var flagEmpty = true;

    var tempMap = await tempdb.rawQuery('SELECT COUNT(*) FROM PRAYER_TIMES');
    print(tempMap);

    //Check if Database Empty
    if (tempMap[0]["COUNT(*)"] != 0) {
      flagEmpty = false;
    }

    if (flagEmpty) {
      print('Database IS Empty');
      return true;
    } else {
      print('Database NOT Empty');
      //Check if Date Exists
      final tempTime = await tempdb.query(
        "PRAYER_TIMES",
        columns: null,
        where: "Gregorian_Date = ?",
        whereArgs: [tempDate],
      );

      print(tempTime);

      if (tempTime.isEmpty) {
        await tempdb.rawQuery('DELETE FROM PRAYER_TIMES');
        print('Database Deleted');
        print('Date NOT EXIST');
        return true;
      } else {
        print('Date EXISTS');
        return false;
      }
    }
  }
}
