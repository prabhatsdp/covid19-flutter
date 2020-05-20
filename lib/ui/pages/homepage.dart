import 'package:covid_19/bloc/statewise_bloc.dart';
import 'package:covid_19/bloc/update_info_bloc.dart';
import 'package:covid_19/data/repos/patientrepository.dart';
import 'package:covid_19/data/repos/update_repository.dart';
import 'package:covid_19/services/analytics.dart';
import 'package:covid_19/ui/widgets/animated_bottom_bar.dart';
import 'package:covid_19/ui/widgets/india_details.dart';
import 'package:covid_19/ui/widgets/loading.dart';
import 'package:covid_19/ui/widgets/no_data.dart';
import 'package:covid_19/ui/widgets/pageheader.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const int BOTTOM_BAR_HEIGHT = 60;
  List<NavBarItem> navBarItems = [
    NavBarItem(title: "India", iconData: Icons.pin_drop, color: Colors.blueAccent),
    NavBarItem(title: "Global", iconData: Icons.map, color: Colors.greenAccent[700]),
    NavBarItem(title: "Safety", iconData: Icons.security, color: Colors.amberAccent[700]),
    NavBarItem(title: "About", iconData: Icons.info, color: Colors.deepPurpleAccent),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatewiseBloc>(
          create: (BuildContext context) => StatewiseBloc(
            patientRepository: CovidPatientRepository(),
          ),
        ),
        BlocProvider<UpdateInfoBloc>(
          create: (BuildContext context) {
            return UpdateInfoBloc(
              updateRepository: FirebaseUpdateRepository(),
            )..add(GetUpdateInfo());
          },
        ),
      ],
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.grey[50],
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: PageHeader(title: "India"),
                          ),
                          BlocBuilder<StatewiseBloc, StatewiseState>(
                            builder: (context, state) {
                              if (state is StatewiseInitial) {
                                BlocProvider.of<StatewiseBloc>(context).add(GetPatientData());
                              }
                              if (state is StatewiseLoading) {
                                return showLoadingScreen();
                              }
                              if (state is StatewiseLoaded) {
                                return showIndiaDetails(state.patientDataMap);
                              }
                              if (state is StatewiseError) {
                                print(state.error);
                                return showNoDataScreen();
                              }
                              return showLoadingScreen();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // bottomNavigationBar: AnimatedBottomBar(navBarItems: navBarItems),
            ),
          );
        },
      ),
    );
  }

  Widget showIndiaDetails(Map<String, List> patientDataMap) {
    return IndiaDetails(
      patientDataMap: patientDataMap,
    );
  }

  Widget showLoadingScreen() {
    return Loading();
  }

  Widget showNoDataScreen() {
    return NoData();
  }
}
