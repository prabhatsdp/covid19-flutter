import 'package:covid_19/data/models/daily_data.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeltaDetailPage extends StatelessWidget {
  final int totalValue;
  final int todayChange;
  final String name;
  final List<DailyData> dailyData;
  Color cardColor;
  DeltaDetailPage(
      {@required this.name, @required this.todayChange, @required this.totalValue, @required this.dailyData, this.cardColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: cardColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Hero(
            tag: name,
            transitionOnUserGestures: true,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: cardColor,
                  image: DecorationImage(
                    image: AssetImage("images/corona_card_big.png"),
                    fit: BoxFit.none,
                    alignment: Alignment.center,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 16,
                        right: 16,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 8,
                            left: 0,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                todayChange.isNegative ? Helper.formatNumber(todayChange) : "+" + Helper.formatNumber(todayChange),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              IntrinsicHeight(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
