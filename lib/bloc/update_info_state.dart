part of 'update_info_bloc.dart';

@immutable
abstract class UpdateInfoState {
  const UpdateInfoState();
}

class UpdateInfoInitial extends UpdateInfoState {
  const UpdateInfoInitial();
}

class UpdateInfoLoading extends UpdateInfoState {
  const UpdateInfoLoading();
}

class UpdateInfoLoaded extends UpdateInfoState {
  final UpdateInfo updateInfo;
  const UpdateInfoLoaded({@required this.updateInfo});
}

class UpdateInfoError extends UpdateInfoState {
  final String error;
  const UpdateInfoError({@required this.error});
}
