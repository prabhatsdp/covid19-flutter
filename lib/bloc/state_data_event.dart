part of 'state_data_bloc.dart';

@immutable
abstract class StateDataEvent {
  const StateDataEvent();
}

class GetStatePatientData extends StateDataEvent {
  final String stateCode;
  const GetStatePatientData({@required this.stateCode});
}

