import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Summary {
  String _name;
  int _value;

  Summary({@required String name, @required int value}) {
    this._name = name;
    this._value = value;
  }

  set name(String name) => _name = name;
  set value(int value) => _value = value;

  String get name => this._name;
  int get value => this._value;
}
