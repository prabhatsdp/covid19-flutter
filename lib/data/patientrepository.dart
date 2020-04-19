import 'dart:convert';

import 'package:covid_19/data/models/my_state_data.dart';
import 'package:http/http.dart' as http;

abstract class PatientRepository {
  Future<List<MyStateData>> fetchStateWiseData();
}

class CovidPatientRepository extends PatientRepository {
  @override
  Future<List<MyStateData>> fetchStateWiseData() async {
    // TODO: implement fetchStateWiseData
    List<MyStateData> stateDataList = List();
    String url = "https://api.covid19india.org/data.json";
    var res = await http.get(Uri.encodeFull(url), headers: {"Acceppt": "appplication/json"});


    if(res.statusCode == 200) {
      var data = json.decode(res.body);
      var stateWise = data["statewise"] as List;
      stateDataList = stateWise.map<MyStateData>((json) => MyStateData.fromJson(json)).toList();
    } else {
      throw Error();
    }
    print("List length: ${stateDataList.length}");
    print(stateDataList[0]);

    return stateDataList;
  }

}