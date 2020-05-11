import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadioModel {
  final dynamic value;
  final dynamic selectedValue;
  final String title;
  final Color bgColor;
  final Color textColor;
  Radio radio;
  bool isSelected;

CustomRadioModel({ @required this.value, @required this.selectedValue, @required this.title, @required this.bgColor, this.textColor = Colors.black, this.isSelected}){
    isSelected = value == selectedValue;
  }

  set selected(bool isSelected) => this.isSelected = isSelected;

  


}