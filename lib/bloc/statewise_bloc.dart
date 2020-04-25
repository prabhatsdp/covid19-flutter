import 'dart:async';

import 'package:covid_19/data/models/my_state_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid_19/data/patientrepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'statewise_event.dart';
part 'statewise_state.dart';

class StatewiseBloc extends Bloc<StatewiseEvent, StatewiseState> {
  final PatientRepository patientRepository;

  StatewiseBloc({this.patientRepository});

  @override
  StatewiseState get initialState => StatewiseInitial();

  @override
  Stream<StatewiseState> mapEventToState(
    StatewiseEvent event,
  ) async* {
    // TODO: implement mapEventToState
    yield StatewiseLoading();
    if (event is GetPatientData) {
      try {
        final patientData = await patientRepository.fetchPatientData();
        yield StatewiseLoaded(patientDataMap: patientData);
      } catch (error) {
        print(error);
        yield StatewiseError(error: "Data couldn't be loaded.");
      }
    }
  }
}
