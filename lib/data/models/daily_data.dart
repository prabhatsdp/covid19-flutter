import 'package:flutter/cupertino.dart';

class DailyData {
  String _date;
  int _dailyConfirmed;
  int _dailyDeaths;
  int _dailyRecovered;
  int _totalConfirmed;
  int _totalDeaths;
  int _totalRecovered;
  int _totalActive;

  DailyData({
    @required date,
    @required dailyConfirmed,
    @required dailyDeaths,
    @required dailyRecovered,
    @required totalConfirmed,
    @required totalDeaths,
    @required totalRecovered,
  }) {
    this._date = date;
    this._dailyConfirmed = dailyConfirmed;
    this._dailyDeaths = dailyDeaths;
    this._dailyRecovered = dailyRecovered;
    this._totalConfirmed = totalConfirmed;
    this._totalDeaths = totalDeaths;
    this._totalRecovered = totalRecovered;
    this._totalActive = totalConfirmed - totalRecovered - totalDeaths;
  }

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      date: json["date"],
      dailyConfirmed: int.tryParse(json["dailyconfirmed"]) ?? 0,
      dailyDeaths: int.tryParse(json["dailydeceased"]) ?? 0,
      dailyRecovered: int.tryParse(json["dailyrecovered"]) ?? 0,
      totalConfirmed: int.tryParse(json["totalconfirmed"]) ?? 0,
      totalDeaths: int.tryParse(json["totaldeceased"]) ?? 0,
      totalRecovered: int.tryParse(json["totalrecovered"]) ?? 0,
    );
  }

  set date(String date) => this._date = date;
  set dailyConfirmed(int dailyConfirmed) => this._dailyConfirmed = dailyConfirmed;
  set dailyDeaths(int dailyDeaths) => this._dailyDeaths = dailyDeaths;
  set dailyRecovered(int dailyRecovered) => this._dailyRecovered = dailyRecovered;
  set totalConfirmed(int totalConfirmed) => this._totalConfirmed = totalConfirmed;
  set totalDeaths(int totalDeaths) => this._totalDeaths = totalDeaths;
  set totalRecovered(int totalRecovered) => this._totalRecovered = totalRecovered;

  String get date => this._date;
  int get dailyConfirmed => this._dailyConfirmed;
  int get dailyDeaths => this._dailyDeaths;
  int get dailyRecovered => this._dailyRecovered;
  int get totalConfirmed => this._totalConfirmed;
  int get totalDeaths => this._totalDeaths;
  int get totalRecovered => this._totalRecovered;
  int get totalActive => this._totalActive;
}
