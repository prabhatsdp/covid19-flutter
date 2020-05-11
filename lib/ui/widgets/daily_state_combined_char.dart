import 'dart:math';

import 'package:covid_19/data/models/custom_radio_model.dart';
import 'package:covid_19/data/models/my_state_single_value.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:covid_19/ui/widgets/touched_data_capsule.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'custom_radio_button.dart';

class DailyStateCombinedChart extends StatefulWidget {
  final Map<String, List<MyStateSingleValue>> statePatientDataMap;
  final accentColor = Colors.blueAccent;
  final cnfChartColor = Colors.blueAccent;
  final activeChartColor = Colors.amberAccent[700];
  final rcvrdChartColor = Colors.greenAccent[700];
  final deathsChartColor = Colors.redAccent;

  // List<MyStateSingleValue> confirmedCumulativeList = List();
  // List<MyStateSingleValue> activeCumulativeList = List();
  // List<MyStateSingleValue> recoveredCumulativeList = List();
  // List<MyStateSingleValue> deathsCumulativeList = List();
  List<MyStateSingleValue> confirmedDailyList = List();
  List<MyStateSingleValue> activeDailyList = List();
  List<MyStateSingleValue> recoveredDailyList = List();
  List<MyStateSingleValue> deathsDailyList = List();
  DailyStateCombinedChart({Key key, this.statePatientDataMap}) : super(key: key) {
    // confirmedCumulativeList = this.statePatientDataMap["cnf_state_cumulative_data"];
    // activeCumulativeList = this.statePatientDataMap["active_state_cumulative_data"];
    // recoveredCumulativeList = this.statePatientDataMap["rcvrd_state_cumulative_data"];
    // deathsCumulativeList = this.statePatientDataMap["deaths_state_cumulative_data"];
    confirmedDailyList = this.statePatientDataMap["cnf_state_daily_data"];
    activeDailyList = this.statePatientDataMap["active_state_daily_data"];
    recoveredDailyList = this.statePatientDataMap["rcvrd_state_daily_data"];
    deathsDailyList = this.statePatientDataMap["deaths_state_daily_data"];
  }

  @override
  _DailyStateCombinedChartState createState() => _DailyStateCombinedChartState();
}

class _DailyStateCombinedChartState extends State<DailyStateCombinedChart> {
  static const int CUMULATIVE_CHART = 0;
  static const int DAILY_CHART = 1;
  static const int ONE_WEEK = 7;
  static const int TWO_WEEKS = 14;
  static const int ONE_MONTH = 30;
  static const int BEGINNING = 0;
  int valueDivider = 10000;
  double valueMultiplier = 10;
  int chartLength;
  int selectedValue;
  String selectedDate;
  int selectedCnfValue;
  int selectedActiveValue;
  int selectedRcvrdValue;
  int selectedDeathsValue;
  Color accentColor;
  double touchedSpotXValue;
  bool isSpotSelected;
  int maxDailyData;
  int selectedChartType;
  List<MyStateSingleValue> mCnfStateDataList = List();
  List<MyStateSingleValue> mActiveStateDataList = List();
  List<MyStateSingleValue> mRcvrdStateDataList = List();
  List<MyStateSingleValue> mDeathsStateDataList = List();
  @override
  void initState() {
    super.initState();
    chartLength = 14;
    selectedValue = TWO_WEEKS;
    accentColor = Colors.blueAccent;
    mCnfStateDataList = buildLineChartData(widget.confirmedDailyList, chartLength);
    mActiveStateDataList = buildLineChartData(widget.activeDailyList, chartLength);
    mRcvrdStateDataList = buildLineChartData(widget.recoveredDailyList, chartLength);
    mDeathsStateDataList = buildLineChartData(widget.deathsDailyList, chartLength);
    maxDailyData = getMaxSingleDayDailyDataValue(cnfData: mCnfStateDataList, activeData: mActiveStateDataList, rcvrdData: mRcvrdStateDataList, deathsData: mDeathsStateDataList);
    selectedCnfValue = mCnfStateDataList.last.value;
    selectedActiveValue = mActiveStateDataList.last.value;
    selectedRcvrdValue = mRcvrdStateDataList.last.value;
    selectedDeathsValue = mDeathsStateDataList.last.value;
    selectedDate = Helper.formateDateDDMMMYY(mCnfStateDataList.last.date);
    touchedSpotXValue = (chartLength - 1).toDouble();
    selectedChartType = CUMULATIVE_CHART;
    isSpotSelected = true;
    updateValueDividerAndMultiplier(maxDailyData);
  }

  @override
  Widget build(BuildContext context) {
    return showChart(context);
  }

  Widget showChart(BuildContext context) {
    //todo: show chart here

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                selectedDate,
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
              Spacer(),
              Text(
                "Daily",
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 16,
            right: 16,
            bottom: 8.0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TouchedDataCapsule(
                  title: "Confirmed",
                  value: selectedCnfValue,
                  color: Colors.blueAccent,
                ),
              ),
              Expanded(
                child: TouchedDataCapsule(
                  title: "Active",
                  value: selectedActiveValue,
                  color: Colors.amberAccent[700],
                ),
              ),
              Expanded(
                child: TouchedDataCapsule(
                  title: "Recovered",
                  value: selectedRcvrdValue,
                  color: Colors.greenAccent[700],
                ),
              ),
              Expanded(
                child: TouchedDataCapsule(
                  title: "Deaths",
                  value: selectedDeathsValue,
                  color: Colors.redAccent,
                ),
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
                buildLineChart(
                  cnfStateDataList: mCnfStateDataList,
                  activeStateDataList: mActiveStateDataList,
                  rcvrdStateDataList: mRcvrdStateDataList,
                  deathsStateDataList: mDeathsStateDataList,
                  context: context,
                ),
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
                  bgColor: accentColor,
                  selectedValue: selectedValue,
                ),
                onChanged: () {
                  setState(() {
                    this.chartLength = widget.confirmedDailyList.length;
                    this.selectedValue = BEGINNING;
                    isSpotSelected = false;
                    mCnfStateDataList = buildLineChartData(widget.confirmedDailyList, chartLength);
                    mActiveStateDataList = buildLineChartData(widget.activeDailyList, chartLength);
                    mRcvrdStateDataList = buildLineChartData(widget.recoveredDailyList, chartLength);
                    mDeathsStateDataList = buildLineChartData(widget.deathsDailyList, chartLength);
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
                    bgColor: accentColor,
                    selectedValue: selectedValue,
                  ),
                  onChanged: () {
                    setState(() {
                      this.chartLength = 30;
                      this.selectedValue = ONE_MONTH;
                      isSpotSelected = false;
                      mCnfStateDataList = buildLineChartData(widget.confirmedDailyList, chartLength);
                      mActiveStateDataList = buildLineChartData(widget.activeDailyList, chartLength);
                      mRcvrdStateDataList = buildLineChartData(widget.recoveredDailyList, chartLength);
                      mDeathsStateDataList = buildLineChartData(widget.deathsDailyList, chartLength);
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
                    bgColor: accentColor,
                    selectedValue: selectedValue,
                  ),
                  onChanged: () {
                    setState(() {
                      this.chartLength = 14;
                      this.selectedValue = TWO_WEEKS;
                      isSpotSelected = false;
                      mCnfStateDataList = buildLineChartData(widget.confirmedDailyList, chartLength);
                      mActiveStateDataList = buildLineChartData(widget.activeDailyList, chartLength);
                      mRcvrdStateDataList = buildLineChartData(widget.recoveredDailyList, chartLength);
                      mDeathsStateDataList = buildLineChartData(widget.deathsDailyList, chartLength);
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
                    bgColor: accentColor,
                    selectedValue: selectedValue,
                  ),
                  onChanged: () {
                    setState(() {
                      this.chartLength = 7;
                      this.selectedValue = ONE_WEEK;
                      isSpotSelected = false;
                      mCnfStateDataList = buildLineChartData(widget.confirmedDailyList, chartLength);
                      mActiveStateDataList = buildLineChartData(widget.activeDailyList, chartLength);
                      mRcvrdStateDataList = buildLineChartData(widget.recoveredDailyList, chartLength);
                      mDeathsStateDataList = buildLineChartData(widget.deathsDailyList, chartLength);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  LineChartData buildLineChart({List<MyStateSingleValue> cnfStateDataList, List<MyStateSingleValue> activeStateDataList, List<MyStateSingleValue> rcvrdStateDataList, List<MyStateSingleValue> deathsStateDataList, BuildContext context}) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
        handleBuiltInTouches: false,
        touchCallback: (touchResponse) {
          //todo: show detailed data
          print("TouchInputOffset: " + touchResponse.touchInput.getOffset().toString());
          if (touchResponse.lineBarSpots.length > 0) {
            print("LineBarSpots More than 0");
            MyStateSingleValue cnfSingleValue = cnfStateDataList[touchResponse.lineBarSpots.first.spotIndex];
            MyStateSingleValue activeSingleValue = activeStateDataList[touchResponse.lineBarSpots.first.spotIndex];
            MyStateSingleValue rcvrdSingleValue = rcvrdStateDataList[touchResponse.lineBarSpots.first.spotIndex];
            MyStateSingleValue deathsSingleValue = deathsStateDataList[touchResponse.lineBarSpots.first.spotIndex];
            print("Date is: " + cnfSingleValue.date.toString());
            setState(() {
              print(touchResponse.lineBarSpots.first.spotIndex);
              isSpotSelected = true;
              selectedCnfValue = cnfSingleValue.value;
              selectedActiveValue = activeSingleValue.value;
              selectedRcvrdValue = rcvrdSingleValue.value;
              selectedDeathsValue = deathsSingleValue.value;
              selectedDate = Helper.formateDateDDMMMYY(cnfSingleValue.date);
              touchedSpotXValue = touchResponse.lineBarSpots.first.x;
            });
          } else {
            print("LineBarSpots are equal to 0");
          }
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: widget.accentColor,
          tooltipPadding: EdgeInsets.all(8),
          tooltipRoundedRadius: 8,
          // getTooltipItems: (lineBarSpotList) {
          //   List<LineTooltipItem> lineToolTipItems = List();
          //   lineBarSpotList.forEach(
          //     (lineBarSpot) {
          //       lineToolTipItems.add(
          //         LineTooltipItem(
          //           Helper.formatNumber(singleDayData[lineBarSpot.spotIndex].value),
          //           TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.w600,
          //             fontSize: 14,
          //             fontFamily: "Manrope",
          //           ),
          //         ),
          //       );
          //     },
          //   );
          //   return lineToolTipItems;
          // },
        ),
      ),
      gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingVerticalLine: (index) {
            return FlLine(
              color: widget.accentColor.withOpacity(0.25),
              strokeWidth: 1,
            );
          },
          getDrawingHorizontalLine: (index) {
            return FlLine(
              color: widget.accentColor.withOpacity(0.25),
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
            color: widget.accentColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: "Manrope",
          ),
          getTitles: (value) => getBottomTitle(index: value, numDays: chartLength, data: cnfStateDataList),
        ),
        leftTitles: SideTitles(
          showTitles: true,
          margin: 8,
          getTitles: (value) => getLeftTitle(index: value, data: cnfStateDataList),
          textStyle: TextStyle(
            color: widget.accentColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: "Manrope",
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(
          color: widget.accentColor,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      minX: 0,
      minY: 0,
      maxY: getMaxSingleDayDailyDataValue(cnfData: mCnfStateDataList, activeData: mActiveStateDataList, rcvrdData: mRcvrdStateDataList, deathsData: mDeathsStateDataList) / valueDivider,
      maxX: (chartLength - 1).toDouble(),
      clipToBorder: false,
      lineBarsData: [
        buildLineChartBarData(dataList: cnfStateDataList, chartColor: widget.cnfChartColor),
        buildLineChartBarData(dataList: activeStateDataList, chartColor: widget.activeChartColor),
        buildLineChartBarData(dataList: rcvrdStateDataList, chartColor: widget.rcvrdChartColor),
        buildLineChartBarData(dataList: deathsStateDataList, chartColor: widget.deathsChartColor),
      ],
    );
  }

  List<MyStateSingleValue> buildLineChartData(List<MyStateSingleValue> fullDataList, int _chartLength) {
    print("=====================Function Called======================");
    List<MyStateSingleValue> tempList = new List();
    for (int index = 0; index < _chartLength; index++) {
      tempList.add(fullDataList[index]);
    }
    return tempList.reversed.toList();
  }

  LineChartBarData buildLineChartBarData({
    List<MyStateSingleValue> dataList,
    Color chartColor,
  }) {
    return LineChartBarData(
      spots: buildFlSpots(dataList),
      isCurved: false,
      colors: [
        chartColor.withOpacity(0.8)
      ],
      dotData: FlDotData(
        show: true,
        dotSize: getDotSize(selectedValue),
        strokeWidth: 0,
        getStrokeColor: (flSpot, __, ___) {
          return (touchedSpotXValue == flSpot.x && isSpotSelected) ? chartColor : chartColor.withOpacity(0.75);
        },
        getDotColor: (flSpot, __, ___) {
          return (touchedSpotXValue == flSpot.x && isSpotSelected) ? chartColor : chartColor.withOpacity(0.75);
        },
        // checkToShowDot: (FlSpot flSpot, LineChartBarData lineChartBarData) {
        //   return touchedSpotXValue == flSpot.x && isSpotSelected;
        // },
      ),
      barWidth: getBarWidth(selectedValue),
      isStrokeCapRound: true,
      shadow: Shadow(blurRadius: 0, color: Colors.transparent, offset: Offset(0, 0)),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          chartColor.withOpacity(0.40),
          chartColor.withOpacity(0.0),
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
            color: chartColor.withOpacity(0.5),
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
    );
  }

  List<FlSpot> buildFlSpots(List<MyStateSingleValue> singleDayData) {
    List<FlSpot> flSpots = List();
    for (int i = 0; i < singleDayData.length; i++) {
      MyStateSingleValue item = singleDayData[i];
      flSpots.add(FlSpot(
        i.toDouble(),
        item.value.isNegative ? 0 : item.value.toDouble() / valueDivider,
      ));
    }
    return flSpots;
  }

  String getBottomTitle({double index, int numDays, List<MyStateSingleValue> data}) {
    if (numDays == 14) {
      if ([
        0,
        3,
        6,
        9,
        12
      ].contains(index.toInt())) {
        return Helper.formateDateDDMMMYY(data[index.toInt()].date);
      }
      return "";
    } else if (numDays == 7) {
      if ([
        1,
        3,
        5
      ].contains(index.toInt())) {
        return Helper.formateDateDDMMMYY(data[index.toInt()].date);
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
        return Helper.formateDateDDMMMYY(data[index.toInt()].date);
      }
      return "";
    } else if (numDays == widget.confirmedDailyList.length) {
      num numberToSubtract = widget.confirmedDailyList.length / 25;
      num numberToDivide = widget.confirmedDailyList.length - numberToSubtract.round();
      num numberSteps = double.tryParse((numberToDivide / 4).toString().split(".")[0]);
      if ((numberToDivide) == index.toInt() || index.toInt() == 0) {
        return Helper.formateDateDDMMMYY(data[index.toInt()].date);
      } else if (numberSteps != null && (index.toInt() == numberSteps || index.toInt() == numberSteps * 2 || index.toInt() == numberSteps * 3)) {
        return Helper.formateDateDDMMMYY(data[index.toInt()].date);
      }
    }
    return "";
  }

  String getLeftTitle({double index, List<MyStateSingleValue> data}) {
    if (index > 0 && index % .5 == 0) {
      // int maxValue = data.last.value;
      String title;
      double value = index * valueMultiplier;
      if (maxDailyData < 600) {
        title = (value).toDouble().toStringAsFixed(0);
      } else if (maxDailyData < 3000) {
        title = (value).toDouble().toStringAsFixed(1) + "K";
      } else {
        title = (value).toDouble().toStringAsFixed(0) + "K";
      }
      return title;
    }
    return "";
  }

  int getMaxSingleDayDailyDataValue({List<MyStateSingleValue> cnfData, List<MyStateSingleValue> activeData, List<MyStateSingleValue> rcvrdData, List<MyStateSingleValue> deathsData}) {
    // int maxValue = 0;
    // List<MyStateSingleValue> tempCnfList = List.from(cnfData);
    // List<MyStateSingleValue> tempActiveList = List.from(activeData);
    // List<MyStateSingleValue> tempRcvrdList = List.from(rcvrdData);
    // List<MyStateSingleValue> tempDeathsList = List.from(deathsData);

    List<MyStateSingleValue> tempCombinedList = cnfData + activeData + rcvrdData + deathsData; // [...tempCnfList, ...tempActiveList, ...tempRcvrdList, ...tempDeathsList];

    tempCombinedList.sort((item1, item2) => item1.value - item2.value);
    // tempActiveList.sort((item1, item2) => item1.value - item2.value);
    // tempRcvrdList.sort((item1, item2) => item1.value - item2.value);
    // tempDeathsList.sort((item1, item2) => item1.value - item2.value);
    print("Maximum Value: " + tempCombinedList.last.value.toString());

    return tempCombinedList.last.value;
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

  double getDotSize(int _selectedValue) {
    switch (_selectedValue) {
      case 0:
        return 2;
      case 7:
        return 6;
      case 14:
        return 5;
      case 30:
        return 3;
      default:
        return 3;
    }
  }

  double getBarWidth(int _selectedValue) {
    switch (_selectedValue) {
      case 0:
        return 1.5;
      case 7:
        return 5;
      case 14:
        return 4.0;
      case 30:
        return 2.0;
      default:
        return 4.0;
    }
  }
}
