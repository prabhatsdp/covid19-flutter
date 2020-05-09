import 'package:covid_19/bloc/state_data_bloc.dart';
import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/data/patientrepository.dart';
import 'package:covid_19/ui/widgets/pageheader.dart';
import 'package:covid_19/ui/widgets/state_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatePage extends StatelessWidget {
  final String title;
  final MyStateData stateData;
  const StatePage({Key key, @required this.title, @required this.stateData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StateDataBloc>(
      create: (BuildContext context) => StateDataBloc(
        patientRepository: CovidPatientRepository(),
      ),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.grey[50],
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            body: SafeArea(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    child: PageHeader(title: title),
                  ),
                  StateDetails(
                    stateData: stateData,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
