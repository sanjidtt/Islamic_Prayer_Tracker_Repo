import 'package:auto_size_text/auto_size_text.dart';
import 'package:dart_date/dart_date.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../databases/prayer_tracker_db_provider.dart';

class PrayerTrackerStatScreen extends StatefulWidget {
  @override
  _PrayerTrackerStatScreenState createState() =>
      _PrayerTrackerStatScreenState();
}

class _PrayerTrackerStatScreenState extends State<PrayerTrackerStatScreen> {
  double trackerSize = 0;
  double tempWidth = 20;

  double week1_y = 0;
  double week2_y = 0;
  double week3_y = 0;
  double week4_y = 0;
  double week5_y = 0;
  double week6_y = 0;
  double week7_y = 0;

  String compPrayer = '';

  getData() async {
    var dateTime = DateTime.now();
    var datetimelist;
    String tempDay = '';

    for (int ind = 0; ind <= 6; ind++) {
      datetimelist = dateTime.toString().split(new RegExp(r"[- ]"));
      tempDay = datetimelist[2] + '-' + datetimelist[1] + '-' + datetimelist[0];

      var prayerTrackerData =
          await prayerTrackerDbObj.fetchPrayerTracker(tempDay);

      var tempSum = 0;

      tempSum = prayerTrackerData[0]['Fajr'] +
          prayerTrackerData[0]['Dhuhr'] +
          prayerTrackerData[0]['Asr'] +
          prayerTrackerData[0]['Maghrib'] +
          prayerTrackerData[0]['Isha'];

      setState(() {
        if (ind == 0) {
          week1_y = tempSum.toDouble();
          compPrayer = week1_y.toInt().toString();
        } else if (ind == 1) {
          week2_y = tempSum.toDouble();
        } else if (ind == 2) {
          week3_y = tempSum.toDouble();
        } else if (ind == 3) {
          week4_y = tempSum.toDouble();
        } else if (ind == 4) {
          week5_y = tempSum.toDouble();
        } else if (ind == 5) {
          week6_y = tempSum.toDouble();
        } else if (ind == 6) {
          week7_y = tempSum.toDouble();
        }
      });

      dateTime = dateTime.previousDay;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    trackerSize = MediaQuery.of(context).size.width * 0.3;
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(),
            ),
            Expanded(
              flex: 25,
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 48,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0XFF37B899),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 50,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 5,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        AutoSizeText(
                                          'Your prayer',
                                          maxLines: 1,
                                          maxFontSize: 24,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        AutoSizeText(
                                          'for today',
                                          maxLines: 1,
                                          maxFontSize: 24,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          compPrayer + ' of 5',
                                          maxLines: 1,
                                          maxFontSize: 18,
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        AutoSizeText(
                                          'completed',
                                          maxLines: 1,
                                          maxFontSize: 18,
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: SleekCircularSlider(
                              min: 0,
                              max: 100,
                              initialValue: ((week1_y / 5) * 100),
                              appearance: CircularSliderAppearance(
                                size: trackerSize,
                                startAngle: 180,
                                angleRange: 360,
                                animationEnabled: true,
                                infoProperties: InfoProperties(
                                  mainLabelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                customWidths: CustomSliderWidths(
                                  trackWidth: trackerSize / 10,
                                  progressBarWidth: trackerSize / 10,
                                  handlerSize: trackerSize / 20,
                                  shadowWidth: 0,
                                ),
                                customColors: CustomSliderColors(
                                  trackColor: Color(0XFF3CC7A6),
                                  progressBarColor: Colors.white70,
                                  hideShadow: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(),
            ),
            Expanded(
              flex: 40,
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                  gridData: FlGridData(
                    show: false,
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      right: BorderSide.none,
                      top: BorderSide.none,
                      left: BorderSide(),
                      bottom: BorderSide(),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: leftTitlesBarChart,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitlesBarChart,
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  alignment: BarChartAlignment.spaceEvenly,
                  maxY: 5,
                  minY: 0,
                  barGroups: [
                    myBarChartGroupData(0, week7_y),
                    myBarChartGroupData(1, week6_y),
                    myBarChartGroupData(2, week5_y),
                    myBarChartGroupData(3, week4_y),
                    myBarChartGroupData(4, week3_y),
                    myBarChartGroupData(5, week2_y),
                    myBarChartGroupData(6, week1_y),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData myBarChartGroupData(int varX, double varY) {
    return BarChartGroupData(
      x: varX,
      barRods: [
        BarChartRodData(
          toY: varY,
          width: tempWidth,
          color: Colors.green.withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Color(0XFF247965),
            width: 2,
          ),
        ),
      ],
    );
  }

  Widget bottomTitlesBarChart(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    var dateTime = DateTime.now();
    var datetimelist;
    String tempDay = '';

    var mapDay = {};

    for (int ind = 0; ind <= 6; ind++) {
      datetimelist = dateTime.toString().split(new RegExp(r"[- ]"));
      tempDay = datetimelist[2];
      mapDay[ind] = tempDay;
      dateTime = dateTime.previousDay;
    }

    switch (value.toInt()) {
      case 0:
        text = Text(mapDay[6], style: style);
        break;
      case 1:
        text = Text(mapDay[5], style: style);
        break;
      case 2:
        text = Text(mapDay[4], style: style);
        break;
      case 3:
        text = Text(mapDay[3], style: style);
        break;
      case 4:
        text = Text(mapDay[2], style: style);
        break;
      case 5:
        text = Text(mapDay[1], style: style);
        break;
      case 6:
        text = Text(mapDay[0], style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTitlesBarChart(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0%';
    } else if (value == 1) {
      text = '20%';
    } else if (value == 2) {
      text = '40%';
    } else if (value == 3) {
      text = '60%';
    } else if (value == 4) {
      text = '80%';
    } else if (value == 5) {
      text = '100%';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: AutoSizeText(
        text,
        maxLines: 1,
        style: style,
      ),
    );
  }
}
