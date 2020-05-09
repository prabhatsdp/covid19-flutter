import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:covid_19/data/models/daily_data.dart';
import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/data/models/summary.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:covid_19/ui/pages/delta_detail_page.dart';
import 'package:covid_19/ui/widgets/patient_data_table.dart';
import 'package:covid_19/ui/widgets/summarycard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IndiaDetails extends StatelessWidget {
  final Map<String, List> patientDataMap;
  List<MyStateData> stateWiseData;
  List<DailyData> dailyData;
  MyStateData totalStateData;

  IndiaDetails({@required this.patientDataMap}) {
    stateWiseData = this.patientDataMap["state_wise_data"];
    dailyData = this.patientDataMap["daily_data"];
    totalStateData = stateWiseData.firstWhere((item) => item.state == "Total");
    print(totalStateData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 0,
      ),
      child: Column(
        children: <Widget>[
          WidgetEnterAnimation(
            delay: 0.5,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Text(
                  "Last Updated: " + Helper.parseAndFormatDateFull(totalStateData.lastUpdatedTime),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withBlue(100).withAlpha(150)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          WidgetEnterAnimation(
            delay: 1,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SummaryCard(
                    name: "Confirmed",
                    totalValue: totalStateData.confirmed,
                    todayChange: totalStateData.todayConfirmed,
                    dailyData: dailyData,
                    lastUpdatedTime: totalStateData.lastUpdatedTime,
                    cardColor: Colors.blueAccent,
                    cardImageAlignment: Alignment.centerLeft,
                  ),
                ),
                Expanded(
                  child: SummaryCard(
                    name: "Active",
                    totalValue: totalStateData.active,
                    todayChange: totalStateData.todayConfirmed - totalStateData.todayRecovered - totalStateData.todayDeaths,
                    dailyData: dailyData,
                    lastUpdatedTime: totalStateData.lastUpdatedTime,
                    cardColor: Colors.amberAccent[700],
                    cardImageAlignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          WidgetEnterAnimation(
            delay: 1.5,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SummaryCard(
                    name: "Recovered",
                    totalValue: totalStateData.recovered,
                    todayChange: totalStateData.todayRecovered,
                    dailyData: dailyData,
                    lastUpdatedTime: totalStateData.lastUpdatedTime,
                    cardColor: Colors.greenAccent[700],
                    cardImageAlignment: Alignment.bottomRight,
                  ),
                ),
                Expanded(
                  child: SummaryCard(
                    name: "Deaths",
                    totalValue: totalStateData.deaths,
                    todayChange: totalStateData.todayDeaths,
                    dailyData: dailyData,
                    lastUpdatedTime: totalStateData.lastUpdatedTime,
                    cardColor: Colors.redAccent,
                    cardImageAlignment: Alignment.topRight,
                  ),
                ),
              ],
            ),
          ),
          PatientDataTable(
            stateWiseData: stateWiseData,
          )
        ],
      ),
    );
  }
}
