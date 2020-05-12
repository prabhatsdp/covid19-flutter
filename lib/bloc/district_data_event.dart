part of 'district_data_bloc.dart';

@immutable
abstract class DistrictDataEvent {
  const DistrictDataEvent();
}

class GetStateDistrictData extends DistrictDataEvent {
  final String stateCode;
  const GetStateDistrictData({this.stateCode});
}