part of 'statewise_bloc.dart';

@immutable
abstract class StatewiseState {
  const StatewiseState();
}

class StatewiseInitial extends StatewiseState {
  const StatewiseInitial();
}

class StatewiseLoaded extends StatewiseState {
  final  stateWiseData;
  const StatewiseLoaded({this.stateWiseData});
}

class StatewiseError extends StatewiseState {
  final String error;
  const StatewiseError({this.error});
}
