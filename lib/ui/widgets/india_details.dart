import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:covid_19/data/models/daily_data.dart';
import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/data/models/summary.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:covid_19/ui/pages/delta_detail_page.dart';
import 'package:covid_19/ui/widgets/patient_data_table.dart';
import 'package:covid_19/ui/widgets/summarycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:covid_19/ui/pages/corona_info_page.dart';

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
            delay: 0.75,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 0,
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
              ),
              child: Container(
                height: 170,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      top: 50,
                      child: Container(
                        height: 120,
                        padding: EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width - 32,
                        decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 24,
                          //     spreadRadius: 0,
                          //     color: Colors.blueAccent.withOpacity(0.20),
                          //     offset: Offset(4, 8),
                          //   ),
                          // ],
                          color: Color(0xFF23395D),
                          image: DecorationImage(
                            image: AssetImage("images/corona_card_big.png"),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Spacer(
                              flex: 2,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: AutoSizeText(
                                      "Spread Awareness not Panic.",
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.lightBlue[100], fontWeight: FontWeight.w800, fontSize: 20.0),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "Learn More",
                                          style: TextStyle(color: Colors.lightBlue[100], fontWeight: FontWeight.w800, fontSize: 16.0),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.lightBlue[100],
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 8,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Container(
                          height: 150,
                          child: Image.asset(
                            "images/corona_person.png",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoronaInfoPage(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(4),
                          splashColor: Colors.blueAccent.withOpacity(0.3),
                          highlightColor: Colors.blueAccent.withOpacity(0.15),
                          child: Container(
                            height: 120,
                            padding: EdgeInsets.all(16.0),
                            width: MediaQuery.of(context).size.width - 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SvgPicture.asset("images/corona_person.svg"),
                  ],
                ),
              ),
            ),
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
            isStateDataTable: true,
          )
        ],
      ),
    );
  }
}
