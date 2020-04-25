import 'dart:convert';

import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/data/models/single_day_data.dart';
import 'package:http/http.dart' as http;

import 'models/daily_data.dart';

abstract class PatientRepository {
  Future<Map<String, List>> fetchPatientData();
}

class CovidPatientRepository extends PatientRepository {
  @override
  Future<Map<String, List>> fetchPatientData() async {
    // TODO: implement fetchStateWiseData
    Map<String, List> patientDataMap = Map();
    List<MyStateData> stateDataList = List();
    List<DailyData> dailyDataList = List();
    // List<SingleDayData> confirmedDailyData = List();
    // List<SingleDayData> recoveredDailyData = List();
    // List<SingleDayData> deathsDailyData = List();
    // List<SingleDayData> confirmedTotalDailyData = List();
    // List<SingleDayData> activeTotalDailyData = List();
    // List<SingleDayData> recoveredTotalDailyData = List();
    // List<SingleDayData> deathsTotalDailyData = List();
    String url = "https://api.covid19india.org/data.json";
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "appplication/json"});

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var stateWise = data["statewise"] as List;
      var dailyData = data["cases_time_series"] as List;

      stateDataList = stateWise.map<MyStateData>((json) => MyStateData.fromJson(json)).toList();
      // print(stateDataList);
      patientDataMap["state_wise_data"] = stateDataList;
      // print(patientDataMap);
      dailyDataList = dailyData.map<DailyData>((json) => DailyData.fromJson(json)).toList();
      dailyDataList = dailyDataList.reversed.toList();
      // confirmedDailyData = dailyData.map<SingleDayData>((json) => SingleDayData(date: json["date"], value: json["dailyconfirmed"])).toList();
      // recoveredDailyData = dailyData.map<SingleDayData>((json) => SingleDayData(date: json["date"], value: json["dailyrecovered"])).toList();
      // deathsDailyData = dailyData.map<SingleDayData>((json) => SingleDayData(date: json["date"], value: json["dailydeceased"])).toList();
      // confirmedTotalDailyData = dailyData.map<SingleDayData>((json) => SingleDayData(date: json["date"], value: json["totalconfirmed"])).toList();
      // activeTotalDailyData = dailyData.map<SingleDayData>((json) => SingleDayData(date: json["date"], value: json["dailyconfirmed"])).toList();
      // confirmedDailyData = dailyData.map<SingleDayData>((json) => SingleDayData(date: json["date"], value: json["dailyconfirmed"])).toList();
      // confirmedDailyData = dailyData.map<SingleDayData>((json) => SingleDayData(date: json["date"], value: json["dailyconfirmed"])).toList();
      // print(confirmedDailyData);
      print(dailyDataList[0].totalConfirmed);
      patientDataMap["daily_data"] = dailyDataList;
      // patientDataMap["daily_confirmed_data"] = confirmedDailyData;
      // patientDataMap["daily_active_data"] = activeDailyData;
      // patientDataMap["daily_recovered_data"] = recoveredDailyData;
      // patientDataMap["daliy_deaths_data"] = deathsDailyData;
    } else {
      print("Error Thrown");
      throw Error();
    }
    print("List length: ${stateDataList.length}");
    print(stateDataList[0]);

    return patientDataMap;
  }
}
