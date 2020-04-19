part of 'statewise_bloc.dart';

@immutable
abstract class StatewiseState {
  const StatewiseState();
}

class StatewiseInitial extends StatewiseState {
  const StatewiseInitial();
}

class StatewiseLoading extends StatewiseState {
  const  StatewiseLoading();
}

class StatewiseLoaded extends StatewiseState {
  final List<MyStateData> stateWiseData;
  const StatewiseLoaded({this.stateWiseData});
}

class StatewiseError extends StatewiseState {
  final String error;
  const StatewiseError({this.error});
}
