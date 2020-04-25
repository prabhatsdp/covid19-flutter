part of 'statewise_bloc.dart';

@immutable
abstract class StatewiseEvent {
  const StatewiseEvent();
}

class GetPatientData extends StatewiseEvent {
  const GetPatientData();
}
