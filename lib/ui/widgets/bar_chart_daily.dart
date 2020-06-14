import 'package:covid_19/data/models/custom_radio_model.dart';
import 'package:covid_19/data/models/daily_data.dart';
import 'package:covid_19/data/models/single_day_data.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'custom_radio_button.dart';
import 'date_value.dart';

class BarChartDaily extends StatefulWidget {
  final String name;
  final int totalValue;
  final List<DailyData> dailyData;
  final Color chartColor;

  BarChartDaily({Key key, @required this.name, @required this.totalValue, @required this.dailyData, @required this.chartColor}) : super(key: key);

  @override
  _BarChartDailyState createState() => _BarChartDailyState();
}

class _BarChartDailyState extends State<BarChartDaily> {
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
  int maxDailyValue;

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
    this.maxDailyValue = getMaxSingleDayDailyDataValue(this.singleDayData);
    updateValueDividerAndMultiplier(this.maxDailyValue);
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
                    "Daily",
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
                  child: BarChart(
                    //todo: implement the function wherever it is declared =======================================
                    buildBarChart(singleDayData, context),
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

  BarChartData buildBarChart(List<SingleDayData> singleDayData, BuildContext context) {
    singleDayData = singleDayData.reversed.toList();
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(
        enabled: false,
        handleBuiltInTouches: false,
        touchCallback: (barTouchResponse) {
          //todo: show detailed data
          print("TouchInputOffset: " + barTouchResponse.touchInput.getOffset().toString());
          if (barTouchResponse.spot != null && barTouchResponse.touchInput is! FlPanEnd && barTouchResponse.touchInput is! FlLongPressEnd) {
            print("LineBarSpots More than 0");
            SingleDayData sdData = singleDayData[barTouchResponse.spot.touchedBarGroupIndex];
            setState(() {
              print(barTouchResponse.spot.touchedBarGroupIndex);
              isSpotSelected = true;
              selectedCount = sdData.value;
              selectedDate = sdData.date;
              touchedSpotXValue = barTouchResponse.spot.spot.x;
            });
          } else {
            print("LineBarSpots are equal to 0");
          }
        },
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: widget.chartColor,
            tooltipPadding: EdgeInsets.all(8),
            tooltipRoundedRadius: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(Helper.formatNumber(singleDayData[groupIndex].value), TextStyle());
            }),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (index) {
          return FlLine(
            color: widget.chartColor.withOpacity(0.25),
            strokeWidth: 1,
          );
        },
      ),
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
            fontFamily: "Niramit",
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
            fontFamily: "Niramit",
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minY: 0,
      maxY: getMaxSingleDayDailyDataValue(singleDayData) / valueDivider,
      barGroups: buildBarGroups(singleDayData),
    );
  }

  List<BarChartGroupData> buildBarGroups(List<SingleDayData> singleDayData) {
    List<BarChartGroupData> barChartGroups = List();
    for (int i = 0; i < singleDayData.length; i++) {
      SingleDayData item = singleDayData[i];
      barChartGroups.add(
        BarChartGroupData(x: i, barRods: [
          BarChartRodData(
            width: getWidth(selectedValue),
            y: item.value.isNegative ? 0 : item.value / valueDivider,
            color: getColor(i, touchedSpotXValue),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ]),
      );
    }
    return barChartGroups;
  }

  List<SingleDayData> buildChartDataList(List<DailyData> dailyData) {
    List<SingleDayData> singleDayDataList = List();
    // List<FlSpot> flSpots = List();
    if (this.name == "Confirmed") {
      for (int i = 0; i < chartLength; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].dailyConfirmed));
        // flSpots.add(FlSpot(i.toDouble(), dailyData[i].dailyConfirmed.toDouble()));
      }
    } else if (this.name == "Active") {
      for (int i = 0; i < chartLength; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].dailyActive));
        // flSpots.add(FlSpot(i.toDouble(), dailyData[i].dailyActive.toDouble()));
      }
    } else if (this.name == "Recovered") {
      for (int i = 0; i < chartLength; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].dailyRecovered));
        // flSpots.add(FlSpot(i.toDouble(), dailyData[i].dailyRecovered.toDouble()));
      }
    } else if (this.name == "Deaths") {
      for (int i = 0; i < chartLength; i++) {
        singleDayDataList.add(SingleDayData(date: dailyData[i].date, value: dailyData[i].dailyDeaths));
        // flSpots.add(FlSpot(i.toDouble(), dailyData[i].dailyDeaths.toDouble()));
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
      print("Function Called and If true");
      String title;
      double value = index * valueMultiplier;
      if (maxDailyValue < 600) {
        title = (value).toDouble().toStringAsFixed(0);
      } else if (maxDailyValue < 3000) {
        title = (value).toDouble().toStringAsFixed(1) + "K";
      } else {
        title = (value).toDouble().toStringAsFixed(0) + "K";
      }
      return title;
    }

    print("Function Called and If false");
    return "";
  }

  void updateValueDividerAndMultiplier(int maxValue) {
    if (maxValue < 120) {
      valueDivider = 20;
      valueMultiplier = 20;
    } else if (maxValue < 600) {
      valueDivider = 100;
      valueMultiplier = 100;
    } else if (maxValue < 1200) {
      valueDivider = 200;
      valueMultiplier = 0.2;
    } else if (maxValue < 3000) {
      valueDivider = 500;
      valueMultiplier = 0.5;
    } else if (maxValue < 6000) {
      valueDivider = 1000;
      valueMultiplier = 1;
    } else if (maxValue < 12000) {
      valueDivider = 2000;
      valueMultiplier = 2;
    } else if (maxValue < 30000) {
      valueDivider = 5000;
      valueMultiplier = 5;
    } else if (maxValue < 60000) {
      valueDivider = 10000;
      valueMultiplier = 10;
    } else if (maxValue < 120000) {
      valueDivider = 20000;
      valueMultiplier = 20;
    } else if (maxValue < 300000) {
      valueDivider = 50000;
      valueMultiplier = 50;
    } else if (maxValue < 600000) {
      valueDivider = 100000;
      valueMultiplier = 100;
    } else if (maxValue < 1200000) {
      valueDivider = 200000;
      valueMultiplier = 200;
    } else if (maxValue < 3000000) {
      valueDivider = 500000;
      valueMultiplier = 500;
    } else if (maxValue < 6000000) {
      valueDivider = 1000000;
      valueMultiplier = 1000;
    }
  }

  int getMaxSingleDayDailyDataValue(List<SingleDayData> singleDayData) {
    List<SingleDayData> tempList = List.from(singleDayData);
    tempList.sort((item1, item2) => item1.value - item2.value);
    print("Maximum Value: " + tempList.last.value.toString());
    return tempList.last.value;
  }

  double getWidth(int selectedValue) {
    switch (selectedValue) {
      case 0:
        return 1.5;
      case 7:
        return 16.0;
      case 14:
        return 10.0;
      case 30:
        return 6.0;
      default:
        return 8.0;
    }
  }

  getColor(int i, double touchedSpotXValue) {
    if(!this.isSpotSelected) {
      return this.chartColor.withOpacity(0.8);
    }
    if(i == touchedSpotXValue) {
      return this.chartColor;
    } else {
      return this.chartColor.withOpacity(0.6);
    }
  }
}
