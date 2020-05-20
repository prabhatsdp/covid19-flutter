import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UpdateEntity extends Equatable {
  final bool updateAvailable;
  final bool important;
  final int versionNumber;
  final String versionName;
  final String versionDesc;
  final String downloadLink;

  UpdateEntity({@required this.updateAvailable, @required this.important, @required this.versionNumber, @required this.versionName, @required this.versionDesc, @required this.downloadLink});

  factory UpdateEntity.fromSnapshot(DocumentSnapshot snapshot) {
    return UpdateEntity(
      updateAvailable: snapshot.data["update_available"],
      important: snapshot.data["important"],
      versionNumber: snapshot.data["version_number"],
      versionName: snapshot.data["version_name"],
      versionDesc: snapshot.data["version_desc"],
      downloadLink: snapshot.data["download_link"],
    );
  }

  @override
  String toString() {
    return 'UpdateEntity { updateAvailable : $updateAvailable, important : $important , versionNumber : ${versionNumber.toString()}, versionName : $versionName, versionDesc : $versionDesc, downloadLink : $downloadLink }';
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
