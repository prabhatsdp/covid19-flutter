import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_19/data/models/update_info.dart';
import 'package:covid_19/data/repos/update_repository.dart';
import 'package:meta/meta.dart';

part 'update_info_event.dart';
part 'update_info_state.dart';

class UpdateInfoBloc extends Bloc<UpdateInfoEvent, UpdateInfoState> {
  final UpdateRepository updateRepository;

  UpdateInfoBloc({@required this.updateRepository});

  @override
  UpdateInfoState get initialState => UpdateInfoInitial();

  @override
  Stream<UpdateInfoState> mapEventToState(UpdateInfoEvent event) async* {
    yield UpdateInfoLoading();
    if (event is GetUpdateInfo) {
      try {
        final updateInfo = await updateRepository.fetchUpdateInfo();
        yield UpdateInfoLoaded(updateInfo: updateInfo);
      } catch (error) {
        print(error);
        yield UpdateInfoError(error: error.toString());
      }
    }
  }
}
