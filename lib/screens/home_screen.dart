import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/blocs/bottom_app_bar_bloc.dart';
import 'package:prayer_app/resources/bottom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 250,
            child: MyAppBar(),
          ),
          Expanded(
            flex: 646,
            child: Row(
              children: [
                Expanded(
                  flex: 60,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 500,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 22,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 290,
                        child: QuoteCard(
                          title: ayahTitle,
                          body: ayahBody,
                        ),
                      ),
                      Expanded(
                        flex: 22,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 290,
                        child: QuoteCard(
                          title: hadithTitle,
                          body: hadithBody,
                        ),
                      ),
                      Expanded(
                        flex: 22,
                        child: SizedBox(),
                      ),
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
        ],
      ),
      bottomNavigationBar: NewBottomNavBar(),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final title;
  final body;
  QuoteCard({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF19A883),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          AutoSizeText(
            title,
            maxLines: 1,
            minFontSize: 16,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.white60,
            indent: 50,
            endIndent: 50,
          ),
          AutoSizeText(
            body,
            maxLines: 8,
            //softWrap: false,
            //wrapWords: true,
            minFontSize: 12,
            //stepGranularity: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: AutoSizeText(
                  'Hi Sanjid',
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 24,
                  maxFontSize: 36,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'Lobster',
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: AutoSizeText(
              'Today is',
              maxLines: 1,
              minFontSize: 18,
              maxFontSize: 26,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Oswald',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: AutoSizeText(
              'Friday, 5 August 2022',
              maxLines: 1,
              minFontSize: 18,
              maxFontSize: 26,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Oswald',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
