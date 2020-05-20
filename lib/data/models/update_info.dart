import 'package:covid_19/data/entities/update_entity.dart';
import 'package:flutter/material.dart';

class UpdateInfo {
  final bool updateAvailable;
  final bool important;
  final int versionNumber;
  final String versionName;
  final String versionDesc;
  final String downloadLink;

  UpdateInfo({@required this.updateAvailable, @required this.important, @required this.versionNumber, @required this.versionName, @required this.versionDesc, @required this.downloadLink});

  UpdateEntity toEntity() {
    return UpdateEntity(
      updateAvailable: this.updateAvailable,
      important: this.important,
      versionNumber: this.versionNumber,
      versionName: this.versionName,
      versionDesc: this.versionDesc,
      downloadLink: this.downloadLink,
    );
  }

  factory UpdateInfo.fromEntity(UpdateEntity entity) {
    return UpdateInfo(
      updateAvailable: entity.updateAvailable,
      important: entity.important,
      versionNumber: entity.versionNumber,
      versionName: entity.versionName,
      versionDesc: entity.versionDesc,
      downloadLink: entity.downloadLink,
    );
  }

  @override
  String toString() {
    return 'UpdateEntity { updateAvailable : $updateAvailable, important : $important , versionNumber : ${versionNumber.toString()}, versionName : $versionName, versionDesc : $versionDesc, downloadLink : $downloadLink }';
  }
}
