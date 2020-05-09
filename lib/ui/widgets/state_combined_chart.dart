import 'package:covid_19/data/models/my_state_single_value.dart';
import 'package:flutter/material.dart';

class StateCombinedChart extends StatefulWidget {
  final Map<String, List> statePatientDataMap;
  StateCombinedChart({Key key, @required this.statePatientDataMap}) : super(key: key);

  @override
  _StateCombinedChartState createState() => _StateCombinedChartState();
}

class _StateCombinedChartState extends State<StateCombinedChart> {
  List<MyStateSingleValue> cnfStateDataList = List();
  @override
  void initState() { 
    super.initState();
     cnfStateDataList = widget.statePatientDataMap["cnf_state_daily_data"];

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Data Loaded: "+ cnfStateDataList[0].dateString),
      ),
    );
  }
}
