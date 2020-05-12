part of 'district_data_bloc.dart';

@immutable
abstract class DistrictDataState {
  const DistrictDataState();
}

class DistrictDataInitial extends DistrictDataState {
  const DistrictDataInitial();
}

class DistrictDataLoading extends DistrictDataState {
  const DistrictDataLoading();
}

class DistrictDataLoaded extends DistrictDataState {
  final List<MyStateData> districtWiseData;
  const DistrictDataLoaded({this.districtWiseData});
}

class DistrictDataError extends DistrictDataState {
  final String error;
  const DistrictDataError({this.error});
}

