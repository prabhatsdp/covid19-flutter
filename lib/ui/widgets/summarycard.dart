import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19/data/models/daily_data.dart';
import 'package:covid_19/data/models/single_day_data.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:covid_19/ui/pages/delta_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class SummaryCard extends StatelessWidget {
  static const int CHART_LENGTH = 15;
  final int totalValue;
  final int todayChange;
  final String name;
  final List<DailyData> dailyData;
  final Color cardColor;
  final Alignment cardImageAlignment;
  final String lastUpdatedTime;
  final NumberFormat numberFormatter = new NumberFormat("##,##,##,##,###");

  SummaryCard({
    @required this.totalValue,
    @required this.name,
    @required this.todayChange,
    @required this.dailyData,
    @required this.lastUpdatedTime,
    this.cardColor = Colors.white,
    this.cardImageAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: name,
      transitionOnUserGestures: true,
      child: Material(
        type: MaterialType.transparency,
        child: IntrinsicHeight(
          child: Container(
            height: 200,
            // padding: EdgeInsets.symmetric(
            //   horizontal: 10,
            //   vertical: 10,
            // ),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: cardColor,
              image: DecorationImage(
                image: AssetImage("images/corona_card_big.png"),
                fit: BoxFit.none,
                alignment: cardImageAlignment,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 0,
                  color: cardColor.withAlpha(200),
                  offset: Offset(4, 8),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  // behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeltaDetailPage(
                          name: name,
                          totalValue: totalValue,
                          todayChange: todayChange,
                          dailyData: dailyData,
                          lastUpdatedTime: lastUpdatedTime,
                          cardColor: cardColor,
                        ),
                        settings:  RouteSettings(name: "home/india/${name}_card/details_page")
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.white.withOpacity(0.4),
                  highlightColor: Colors.white.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withAlpha(200),
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
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    Helper.formatNumber(totalValue),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            child: showChart(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showChart() {
    //todo: show chart here
    List<SingleDayData> singleDayData = buildChartDataList(dailyData);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(48),
        ),
      ),
      child: IntrinsicHeight(
        child: LineChart(
          buildLineChart(singleDayData),
        ),
      ),
    );
  }

  LineChartData buildLineChart(List<SingleDayData> singleDayData) {
    singleDayData = singleDayData.reversed.toList();
    List<Color> gradientColors = [
      Colors.white.withAlpha(200)
    ];
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      minY: 0,
      maxY: singleDayData[CHART_LENGTH - 1].value.toDouble(),
      maxX: (CHART_LENGTH - 1).toDouble(),
      clipToBorder: false,
      lineBarsData: [
        LineChartBarData(
          spots: buildFlSpots(singleDayData),
          isCurved: true,
          colors: gradientColors,
          dotData: FlDotData(
            show: true,
            dotSize: 3,
            strokeWidth: 0,
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          shadow: Shadow(blurRadius: 0, color: Colors.transparent, offset: Offset(0, 0)),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              Colors.white.withAlpha(100),
              Colors.white.withAlpha(0),
            ],
            gradientColorStops: [
              0.5,
              0.9
            ],
            gradientFrom: Offset(0, 0),
            gradientTo: Offset(0.3, 1),
            spotsLine: BarAreaSpotsLine(
              show: true,
              flLineStyle: FlLine(
                color: Colors.white.withAlpha(50),
                strokeWidth: 2,
                dashArray: [
                  8,
                  4
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> buildFlSpots(List<SingleDayData> singleDayData) {
    List<FlSpot> flSpots = List();
    for (int i = 0; i < singleDayData.length; i++) {
      SingleDayData item = singleDayData[i];
      flSpots.add(FlSpot(i.toDouble(), item.value.toDouble()));
    }
    return flSpots;
  }

  List<SingleDayData> buildChartDataList(List<DailyData> dailyData) {
    List<SingleDayData> singleDayDataList = List();
    List<FlSpot> flSpots = List();
    if (this.name == "Confirmed") {
      for (int i = 0; i < CHART_LENGTH; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].totalConfirmed));
        flSpots.add(FlSpot(i.toDouble(), dailyData[i].totalConfirmed.toDouble()));
      }
    } else if (this.name == "Active") {
      for (int i = 0; i < CHART_LENGTH; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].totalActive));
        flSpots.add(FlSpot(i.toDouble(), dailyData[i].totalConfirmed.toDouble()));
      }
    } else if (this.name == "Recovered") {
      for (int i = 0; i < CHART_LENGTH; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].totalRecovered));
        flSpots.add(FlSpot(i.toDouble(), dailyData[i].totalConfirmed.toDouble()));
      }
    } else if (this.name == "Deaths") {
      for (int i = 0; i < CHART_LENGTH; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].totalDeaths));
        flSpots.add(FlSpot(i.toDouble(), dailyData[i].totalConfirmed.toDouble()));
      }
    }
    return singleDayDataList;
  }
}
