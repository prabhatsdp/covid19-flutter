import 'package:flutter/material.dart';

class InfoCardModel {
  String _title;
  String _imageSrc;
  Color _cardColor;

  InfoCardModel({@required String title, @required String imageSrc, Color cardColor = Colors.blueAccent}) {
    this._title = title;
    this._imageSrc = imageSrc;
    this._cardColor = cardColor;
  }

  set title(String title) => this._title = title;
  set imageSrc(String imageSrc) => this._imageSrc = imageSrc;
  set cardColor(Color cardColor) => this._cardColor = cardColor;

  String get title => this._title;
  String get imageSrc => this._imageSrc;
  Color get cardColor => this._cardColor;

  @override
  String toString() {
    // TODO: implement toString
    return 'InfoCardModel { title : "${this._title}", imageSrc : "${this._imageSrc}", cardColor : "${this._cardColor}"}';
  }
}
