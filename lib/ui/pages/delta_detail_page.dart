import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:covid_19/data/models/daily_data.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:covid_19/ui/widgets/bar_chart_daily.dart';
import 'package:covid_19/ui/widgets/line_chart_cumulative.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeltaDetailPage extends StatelessWidget {
  static const int CHART_LENGTH = 15;
  final int totalValue;
  final int todayChange;
  final String name;
  final List<DailyData> dailyData;
  final Color cardColor;
  final String lastUpdatedTime;
  DeltaDetailPage({
    @required this.name,
    @required this.todayChange,
    @required this.totalValue,
    @required this.dailyData,
    @required this.lastUpdatedTime,
    this.cardColor = Colors.white,
  });

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
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  decoration: BoxDecoration(
                    color: cardColor,
                    image: DecorationImage(
                      image: AssetImage("images/corona_card_big.png"),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 24,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: name,
                        transitionOnUserGestures: true,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 8,
                                  left: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    splashColor: Colors.white,
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        name,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            todayChange.isNegative ? Helper.formatNumber(todayChange) : "+" + Helper.formatNumber(todayChange),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            " Today",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white.withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        Helper.formatNumber(totalValue),
                                        style: TextStyle(
                                          fontSize: 42,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        Helper.parseAndFormatDateFull(lastUpdatedTime),
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      WidgetEnterAnimation(
                        delay: 0,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 16,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                color: cardColor.withOpacity(0.25),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: LineChartCumulative(
                            name: name,
                            totalValue: totalValue,
                            dailyData: dailyData,
                            chartColor: cardColor,
                          ),
                        ),
                      ),
                      WidgetEnterAnimation(
                        delay: 0.5,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 16,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                color: cardColor.withOpacity(0.25),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: BarChartDaily(
                            name: name,
                            totalValue: totalValue,
                            dailyData: dailyData,
                            chartColor: cardColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
