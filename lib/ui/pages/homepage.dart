import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:covid_19/bloc/statewise_bloc.dart';
import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/data/models/summary.dart';
import 'package:covid_19/data/patientrepository.dart';
import 'package:covid_19/ui/widgets/animated_bottom_bar.dart';
import 'package:covid_19/ui/widgets/india_details.dart';
import 'package:covid_19/ui/widgets/loading.dart';
import 'package:covid_19/ui/widgets/no_data.dart';
import 'package:covid_19/ui/widgets/pageheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const int BOTTOM_BAR_HEIGHT = 60;
  List<NavBarItem> navBarItems = [
    NavBarItem(
        title: "India", iconData: Icons.pin_drop, color: Colors.blueAccent),
    NavBarItem(
        title: "Global", iconData: Icons.map, color: Colors.greenAccent[700]),
    NavBarItem(
        title: "Safety",
        iconData: Icons.security,
        color: Colors.amberAccent[700]),
    NavBarItem(
        title: "About", iconData: Icons.info, color: Colors.deepPurpleAccent),
  ];

  List<Summary> _summaryList = [
    Summary(name: "Confirmed", value: 5000000),
    Summary(name: "Active", value: 4800000),
    Summary(name: "Recovered", value: 5821),
    Summary(name: "Deaths", value: 1500),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatewiseBloc>(
      create: (BuildContext context) => StatewiseBloc(
        patientRepository: CovidPatientRepository(),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        viewportConstraints.maxHeight - BOTTOM_BAR_HEIGHT,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: PageHeader(),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        BlocBuilder<StatewiseBloc, StatewiseState>(
                          builder: (context, state) {
                            if (state is StatewiseInitial) {
                              BlocProvider.of<StatewiseBloc>(context)
                                  .add(GetStatewiseData());
                            }
                            if (state is StatewiseLoading) {
                              return showLoadingScreen();
                            }
                            if (state is StatewiseLoaded) {
                              return showIndiaDetails(state.stateWiseData);
                            }
                            if (state is StatewiseError) {
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
            bottomNavigationBar: AnimatedBottomBar(navBarItems: navBarItems),
          );
        },
      ),
    );
  }

  Widget showIndiaDetails(List<MyStateData> stateWiseData) {
    return IndiaDetails(
      summaryList: _summaryList,
      stateWiseData: stateWiseData,
    );
  }

  Widget showLoadingScreen() {
    return Loading();
  }

  Widget showNoDataScreen() {
    return NoData();
  }
}
