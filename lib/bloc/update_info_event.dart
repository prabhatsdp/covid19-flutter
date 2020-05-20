part of 'update_info_bloc.dart';

@immutable
abstract class UpdateInfoEvent {
  const UpdateInfoEvent();
}

class GetUpdateInfo extends UpdateInfoEvent {
  const GetUpdateInfo();
}
