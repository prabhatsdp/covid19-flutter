import 'package:covid_19/misc/helper.dart';
import 'package:flutter/cupertino.dart';

class MyStateSingleValue {
  Map<String, String> stateNamesMap = {
    "AN": "Andaman and Nicobar Islands",
    "AP": "Andhra Pradesh",
    "AR": "Arunachal Pradesh",
    "AS": "Assam",
    "BR": "Bihar",
    "CH": "Chandigarh",
    "CT": "Chhattisgarh",
    "DD": "Daman and Diu",
    "DL": "Delhi",
    "DN": "Dadra and Nagar Heveli",
    "GA": "Goa",
    "GJ": "Gujarat",
    "HP": "Himachal Pradesh",
    "HR": "Haryana",
    "JH": "Jharkhand",
    "JK": "Jammu and Kashmir",
    "KA": "Karnataka",
    "KL": "Kerala",
    "LA": "Ladakh",
    "LD": "Lakshadweep",
    "MH": "Maharashtra",
    "ML": "Meghalaya",
    "MN": "Manipur",
    "MP": "Madhya Pradesh",
    "MZ": "Mizoram",
    "NL": "Nagaland",
    "OR": "Odisha",
    "PB": "Punjab",
    "PY": "Puduchery",
    "RJ": "Rajasthan",
    "SK": "Sikkim",
    "TG": "Telangana",
    "TN": "Tamil Nadu",
    "TR": "Tripura",
    "TT": "Total",
    "UP": "Uttar Pradesh",
    "UT": "Uttarakhand",
    "WB": "West Bengal",
  };

  String _stateCode;
  String _status;
  String _stateName;
  int _value;
  String _dateString;
  DateTime _date;

  MyStateSingleValue({@required String stateCode, @required String status, @required int value, @required String dateString}) {
    this._stateCode = stateCode;
    this._stateName = stateNamesMap[stateCode.toUpperCase()];
    this._status = status;
    this._value = value != null ? value : 0;
    this._dateString = dateString;
    this._date = Helper.parseDateTimeDDMMMYY(dateString);
  }

  set stateCode(String stateCode) => this._stateCode = stateCode;
  set status(String status) => this._status = status;
  set statename(String stateCode) => this._stateName = stateNamesMap[stateCode.toUpperCase()];
  set value(int value) => this._value = value;
  set dateString(String dateString) => this._dateString = dateString;
  set date(DateTime date) => this._date = date;

  String get stateCode => this._stateCode;
  String get stateName => this._stateName;
  String get status => this._status;
  int get value => this._value;
  String get dateString => this._dateString;
  DateTime get date => this._date;

  bool equals({String stateCode}) {
    if (stateCode.toUpperCase() == this._stateCode || stateCode.toLowerCase() == this._stateCode) return true;
    return false;
  }

  bool dateEquals(String dateString) {
    return this._dateString == dateString;
  }

  @override
  String toString() {
    // TODO: implement toString
    return " $stateName : { stateCode : $stateCode, status : $status, value : $value, dateString : $dateString, date : ${date.toString()}} ";
  }
}
