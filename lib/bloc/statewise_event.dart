part of 'statewise_bloc.dart';

@immutable
abstract class StatewiseEvent {
  const StatewiseEvent();
}

class GetStatewiseData extends StatewiseEvent {
  const GetStatewiseData();
}
