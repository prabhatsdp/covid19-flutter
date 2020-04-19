import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/data/models/summary.dart';
import 'package:covid_19/ui/widgets/summarycard.dart';
import 'package:flutter/material.dart';

class IndiaDetails extends StatelessWidget {
  final List<Summary> summaryList;
  final List<MyStateData> stateWiseData;
  MyStateData totalStateData;

  IndiaDetails({@required this.summaryList, @required this.stateWiseData}) {
    totalStateData =
        this.stateWiseData.firstWhere((item) => item.state == "Total");
    print(totalStateData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: SummaryCard(
                  name: "Confirmed",
                  value: totalStateData.confirmed,
                ),
              ),
              Expanded(
                child: SummaryCard(
                  name: "Active",
                  value: totalStateData.active,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SummaryCard(
                  name: "Recovered",
                  value: totalStateData.recovered,
                ),
              ),
              Expanded(
                child: SummaryCard(
                  name: "Deaths",
                  value: totalStateData.deaths,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
