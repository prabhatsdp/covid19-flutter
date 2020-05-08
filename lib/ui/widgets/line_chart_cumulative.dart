import 'package:covid_19/data/models/custom_radio_model.dart';
import 'package:covid_19/data/models/daily_data.dart';
import 'package:covid_19/data/models/single_day_data.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:covid_19/ui/widgets/custom_radio_button.dart';
import 'package:covid_19/ui/widgets/date_value.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartCumulative extends StatefulWidget {
  final String name;
  final int totalValue;
  final List<DailyData> dailyData;
  final Color chartColor;
  LineChartCumulative({Key key, @required this.name, @required this.totalValue, @required this.dailyData, @required this.chartColor}) : super(key: key);

  @override
  _LineChartCumulativeState createState() => _LineChartCumulativeState();
}

class _LineChartCumulativeState extends State<LineChartCumulative> {
  int valueDivider = 10000;
  double valueMultiplier = 10;
  int chartLength = 14;
  int selectedValue = 14;
  String name;
  int totalValue;
  List<DailyData> dailyData = List();
  Color chartColor;
  String selectedDate;
  int selectedCount;
  double touchedSpotXValue;
  bool isSpotSelected;
  List<CustomRadioModel> radioModels = List();
  List<SingleDayData> singleDayData = List();
  // DateValue dateValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.name = widget.name;
    this.totalValue = widget.totalValue;
    this.dailyData = widget.dailyData;
    this.chartColor = widget.chartColor;
    this.isSpotSelected = false;
    this.singleDayData = buildChartDataList(dailyData);
    this.selectedDate = singleDayData.first.date;
    this.selectedCount = singleDayData.first.value;
    updateValueDividerAndMultiplier(this.totalValue);
    this.touchedSpotXValue = (chartLength - 1).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return showChart(context);
  }

  Widget showChart(BuildContext context) {
    //todo: show chart here
    List<SingleDayData> singleDayData = buildChartDataList(dailyData);
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 6,
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Cumulative",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: chartColor.withOpacity(0.75),
                    ),
                  ),
                  isSpotSelected
                      ? DateValue(
                          selectedDate: selectedDate,
                          selectedCount: selectedCount,
                          chartColor: chartColor,
                        )
                      : Container(
                          height: 28,
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 20,
                right: 20,
              ),
              child: Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                child: IntrinsicHeight(
                  child: LineChart(
                    buildLineChart(singleDayData, context),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomRadioButton(
                    customRadioModel: CustomRadioModel(
                      value: 0,
                      title: "Beginning",
                      bgColor: chartColor,
                      selectedValue: selectedValue,
                    ),
                    onChanged: () {
                      setState(() {
                        this.selectedValue = 0;
                        this.chartLength = dailyData.length;
                        isSpotSelected = false;
                      });
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomRadioButton(
                      customRadioModel: CustomRadioModel(
                        value: 30,
                        title: "1 Month",
                        bgColor: chartColor,
                        selectedValue: selectedValue,
                      ),
                      onChanged: () {
                        setState(() {
                          this.selectedValue = 30;
                          this.chartLength = 30;
                          isSpotSelected = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomRadioButton(
                      customRadioModel: CustomRadioModel(
                        value: 14,
                        title: "2 Weeks",
                        bgColor: chartColor,
                        selectedValue: selectedValue,
                      ),
                      onChanged: () {
                        setState(() {
                          this.selectedValue = 14;
                          this.chartLength = 14;
                          isSpotSelected = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomRadioButton(
                      customRadioModel: CustomRadioModel(
                        value: 7,
                        title: "1 Week",
                        bgColor: chartColor,
                        selectedValue: selectedValue,
                      ),
                      onChanged: () {
                        setState(() {
                          this.selectedValue = 7;
                          this.chartLength = 7;
                          isSpotSelected = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  LineChartData buildLineChart(List<SingleDayData> singleDayData, BuildContext context) {
    singleDayData = singleDayData.reversed.toList();
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
        handleBuiltInTouches: false,
        touchCallback: (touchResponse) {
          //todo: show detailed data
          print("TouchInputOffset: " + touchResponse.touchInput.getOffset().toString());
          if (touchResponse.lineBarSpots.length > 0) {
            print("LineBarSpots More than 0");
            SingleDayData sdData = singleDayData[touchResponse.lineBarSpots.first.spotIndex];
            setState(() {
              print(touchResponse.lineBarSpots.first.spotIndex);
              isSpotSelected = true;
              selectedCount = sdData.value;
              selectedDate = sdData.date;
              touchedSpotXValue = touchResponse.lineBarSpots.first.x;
            });
          } else {
            print("LineBarSpots are equal to 0");
          }
        },
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: widget.chartColor,
            tooltipPadding: EdgeInsets.all(8),
            tooltipRoundedRadius: 8,
            getTooltipItems: (lineBarSpotList) {
              List<LineTooltipItem> lineToolTipItems = List();
              lineBarSpotList.forEach(
                (lineBarSpot) {
                  lineToolTipItems.add(
                    LineTooltipItem(
                      Helper.formatNumber(singleDayData[lineBarSpot.spotIndex].value),
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: "Manrope",
                      ),
                    ),
                  );
                },
              );
              return lineToolTipItems;
            }),
      ),
      gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingVerticalLine: (index) {
            return FlLine(
              color: widget.chartColor.withOpacity(0.25),
              strokeWidth: 1,
            );
          },
          getDrawingHorizontalLine: (index) {
            return FlLine(
              color: widget.chartColor.withOpacity(0.25),
              strokeWidth: 1,
            );
          }),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          margin: 8,
          textStyle: TextStyle(
            color: widget.chartColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: "Manrope",
          ),
          getTitles: (value) => getBottomTitle(index: value, numDays: chartLength, data: singleDayData),
        ),
        leftTitles: SideTitles(
          showTitles: true,
          margin: 8,
          getTitles: (value) => getLeftTitle(index: value, data: singleDayData),
          textStyle: TextStyle(
            color: widget.chartColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: "Manrope",
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(
          color: widget.chartColor,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      minX: 0,
      minY: 0,
      maxY: singleDayData[chartLength - 1].value.toDouble() / valueDivider,
      maxX: (chartLength - 1).toDouble(),
      clipToBorder: false,
      lineBarsData: [
        LineChartBarData(
          spots: buildFlSpots(singleDayData),
          isCurved: true,
          colors: [
            chartColor.withOpacity(0.8)
          ],
          dotData: FlDotData(
            show: true,
            dotSize: 6,
            strokeWidth: 2,
            getStrokeColor: (_, __, ___) {
              return chartColor;
            },
            getDotColor: (_, __, ___) {
              return chartColor;
            },
            checkToShowDot: (FlSpot flSpot, LineChartBarData lineChartBarData) {
              return touchedSpotXValue == flSpot.x && isSpotSelected;
            },
          ),
          barWidth: 6,
          isStrokeCapRound: true,
          shadow: Shadow(blurRadius: 0, color: Colors.transparent, offset: Offset(0, 0)),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              widget.chartColor.withOpacity(0.40),
              widget.chartColor.withOpacity(0.0),
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
                color: widget.chartColor.withOpacity(0.5),
                strokeWidth: 4,
                dashArray: [
                  8,
                  4
                ],
              ),
              checkToShowSpotLine: (FlSpot flSpot) {
                return touchedSpotXValue == flSpot.x && isSpotSelected;
              },
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
      flSpots.add(FlSpot(i.toDouble(), item.value.toDouble() / valueDivider));
    }
    return flSpots;
  }

  List<SingleDayData> buildChartDataList(List<DailyData> dailyData) {
    List<SingleDayData> singleDayDataList = List();
    List<FlSpot> flSpots = List();
    if (this.name == "Confirmed") {
      for (int i = 0; i < chartLength; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].totalConfirmed));
        flSpots.add(FlSpot(i.toDouble(), dailyData[i].totalConfirmed.toDouble()));
      }
    } else if (this.name == "Active") {
      for (int i = 0; i < chartLength; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].totalActive));
        flSpots.add(FlSpot(i.toDouble(), dailyData[i].totalConfirmed.toDouble()));
      }
    } else if (this.name == "Recovered") {
      for (int i = 0; i < chartLength; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].totalRecovered));
        flSpots.add(FlSpot(i.toDouble(), dailyData[i].totalConfirmed.toDouble()));
      }
    } else if (this.name == "Deaths") {
      for (int i = 0; i < chartLength; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].totalDeaths));
        flSpots.add(FlSpot(i.toDouble(), dailyData[i].totalConfirmed.toDouble()));
      }
    }
    return singleDayDataList;
  }

  String getBottomTitle({double index, int numDays, List<SingleDayData> data}) {
    if (numDays == 14) {
      if ([
        0,
        3,
        6,
        9,
        12
      ].contains(index.toInt())) {
        return Helper.parseAndFormatDateDDMMM(data[index.toInt()].date);
      }
      return "";
    } else if (numDays == 7) {
      if ([
        1,
        3,
        5
      ].contains(index.toInt())) {
        return Helper.parseAndFormatDateDDMMM(data[index.toInt()].date);
      }
      return "";
    } else if (numDays == 30) {
      if ([
        0,
        7,
        14,
        21,
        28
      ].contains(index.toInt())) {
        return Helper.parseAndFormatDateDDMMM(data[index.toInt()].date);
      }
      return "";
    } else if (numDays == dailyData.length) {
      num numberToSubtract = dailyData.length / 25;
      num numberToDivide = dailyData.length - numberToSubtract.round();
      num numberSteps = double.tryParse((numberToDivide / 4).toString().split(".")[0]);
      if ((numberToDivide) == index.toInt() || index.toInt() == 0) {
        return Helper.parseAndFormatDateDDMMM(data[index.toInt()].date);
      } else if (numberSteps != null && (index.toInt() == numberSteps || index.toInt() == numberSteps * 2 || index.toInt() == numberSteps * 3)) {
        return Helper.parseAndFormatDateDDMMM(data[index.toInt()].date);
      }
    }
    return "";
  }

  String getLeftTitle({double index, List<SingleDayData> data}) {
    if (index > 0 && index % .5 == 0) {
      String title;
      double value = index * valueMultiplier;
      if (totalValue < 600) {
        title = (value).toDouble().toStringAsFixed(0);
      } else if (totalValue < 3000) {
        title = (value).toDouble().toStringAsFixed(1) + "K";
      } else {
        title = (value).toDouble().toStringAsFixed(0) + "K";
      }
      return title;
    }
    return "";
  }

  void updateValueDividerAndMultiplier(int totalValue) {
    if (totalValue < 120) {
      valueDivider = 20;
      valueMultiplier = 20;
    } else if (totalValue < 600) {
      valueDivider = 100;
      valueMultiplier = 100;
    } else if (totalValue < 1200) {
      valueDivider = 200;
      valueMultiplier = 0.2;
    } else if (totalValue < 3000) {
      valueDivider = 500;
      valueMultiplier = 0.5;
    } else if (totalValue < 6000) {
      valueDivider = 1000;
      valueMultiplier = 1;
    } else if (totalValue < 12000) {
      valueDivider = 2000;
      valueMultiplier = 2;
    } else if (totalValue < 30000) {
      valueDivider = 5000;
      valueMultiplier = 5;
    } else if (totalValue < 60000) {
      valueDivider = 10000;
      valueMultiplier = 10;
    } else if (totalValue < 120000) {
      valueDivider = 20000;
      valueMultiplier = 20;
    } else if (totalValue < 300000) {
      valueDivider = 50000;
      valueMultiplier = 50;
    } else if (totalValue < 600000) {
      valueDivider = 100000;
      valueMultiplier = 100;
    } else if (totalValue < 1200000) {
      valueDivider = 200000;
      valueMultiplier = 200;
    } else if (totalValue < 3000000) {
      valueDivider = 500000;
      valueMultiplier = 500;
    } else if (totalValue < 6000000) {
      valueDivider = 1000000;
      valueMultiplier = 1000;
    }
  }
}
