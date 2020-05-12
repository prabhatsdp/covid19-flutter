part of 'state_data_bloc.dart';

@immutable
abstract class StateDataState {
  const StateDataState();
}

class StateDataInitial extends StateDataState {
  const StateDataInitial();
}

class StateDataLoading extends StateDataState {
  const StateDataLoading();
}


class StateDataLoaded extends StateDataState {
  final Map<String, List<MyStateSingleValue>> patientDataMap;
  const StateDataLoaded({this.patientDataMap});
}

class StateDataError extends StateDataState {
  final String error;
  const StateDataError({this.error});
}



