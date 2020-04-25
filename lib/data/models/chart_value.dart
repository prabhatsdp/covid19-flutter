import 'package:flutter/cupertino.dart';

class ChartValue {
  String _key;
  int _value;

  ChartValue({@required String key,  @required int value}) {
    this._key = key;
    this._value = value;
  }

  set key(String key) => this._key = key;
  set value(int value) => this._value = value;

  get key => this._key;
  get value => this._value;

  @override
  String toString() {
    return 'chart_value: {key: "${this._key}", value: ${this._value}}';
  }
}