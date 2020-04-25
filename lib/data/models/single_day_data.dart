import 'package:flutter/cupertino.dart';

class SingleDayData {
  String _date;
  int _value;

  SingleDayData({@required String date, @required int value}) {
    this._date = date;
    this._value = value;
  }

  set date(String date) => this._date = date;
  set value(int value) => this._value = value;

  String get date => this._date;
  int get value => this._value;

  @override
  String toString() {
    return '"single_day_data" : {"date: : "${this._date}", "value" : ${this._value}}';
  }
}
