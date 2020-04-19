import 'dart:convert';

import 'package:covid_19/data/models/state.dart';
import 'package:http/http.dart' as http;

abstract class PatientRepository {
  Future<List<State>> fetchStateWiseData();
}

class CovidPatientRepository extends PatientRepository {
  @override
  Future<List<State>> fetchStateWiseData() async {
    // TODO: implement fetchStateWiseData
    List<State> stateDataList = List();
    String url = "https://api.covid19india.org/data.json";
    var res = await http.get(Uri.encodeFull(url), headers: {"Acceppt": "appplication/json"});

    if(res.statusCode == 200) {
      var data = json.decode(res.body);
      var stateWise = data["statewise"] as List;
      stateDataList = stateWise.map<State>((json) => State.fromJson(json)).toList();
    } else {
      throw Error();
    }
    print("List length: ${stateDataList.length}");

    return stateDataList;
  }

}