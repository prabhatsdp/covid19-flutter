import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:covid_19/bloc/state_data_bloc.dart';
import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/data/patientrepository.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:covid_19/ui/widgets/daily_state_combined_char.dart';
import 'package:covid_19/ui/widgets/state_combined_chart.dart';
import 'package:covid_19/ui/widgets/state_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading.dart';
import 'no_data.dart';

class StateDetails extends StatelessWidget {
  final MyStateData stateData;
  const StateDetails({Key key, @required this.stateData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 0.0,
      ),
      child: Column(
        children: <Widget>[
          WidgetEnterAnimation(
            delay: 1.2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 12.0,
                ),
                child: Text(
                  "Last Updated: " + Helper.parseAndFormatDateFull(stateData.lastUpdatedTime),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withBlue(100).withAlpha(150),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          WidgetEnterAnimation(
            delay: 1.4,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: StateSummaryCard(
                  cardColor: Colors.blueAccent,
                  lastUpdatedTime: stateData.lastUpdatedTime,
                  todayChange: stateData.todayConfirmed,
                  totalValue: stateData.confirmed,
                  name: "Confirmed",
                )),
                Expanded(
                  child: StateSummaryCard(
                    cardColor: Colors.amberAccent[700],
                    lastUpdatedTime: stateData.lastUpdatedTime,
                    todayChange: stateData.todayConfirmed - stateData.todayRecovered - stateData.todayDeaths,
                    totalValue: stateData.active,
                    name: "Active",
                  ),
                ),
              ],
            ),
          ),
          WidgetEnterAnimation(
            delay: 1.6,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: StateSummaryCard(
                  cardColor: Colors.greenAccent[700],
                  lastUpdatedTime: stateData.lastUpdatedTime,
                  todayChange: stateData.todayRecovered,
                  totalValue: stateData.recovered,
                  name: "Recovered",
                )),
                Expanded(
                  child: StateSummaryCard(
                    cardColor: Colors.redAccent,
                    lastUpdatedTime: stateData.lastUpdatedTime,
                    todayChange: stateData.todayDeaths,
                    totalValue: stateData.deaths,
                    name: "Deaths",
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<StateDataBloc, StateDataState>(
            builder: (context, state) {
              if (state is StateDataInitial) {
                BlocProvider.of<StateDataBloc>(context).add(GetStatePatientData(stateCode: stateData.stateCode));
                return showLoadingScreen();
              }
              if (state is StateDataLoading) {
                return showLoadingScreen();
              }

              if (state is StateDataLoaded) {
                return Column(
                  children: <Widget>[
                    WidgetEnterAnimation(
                      delay: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 16,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                color: Colors.blueAccent.withOpacity(0.25),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: StateCombinedChart(
                            statePatientDataMap: state.patientDataMap,
                          ),
                        ),
                      ),
                    ),
                    WidgetEnterAnimation(
                      delay: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 16,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                color: Colors.blueAccent.withOpacity(0.25),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: DailyStateCombinedChart(
                            statePatientDataMap: state.patientDataMap,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (state is StateDataError) {
                return showNoDataScreen();
              }

              return showLoadingScreen();
            },
          ),
        ],
      ),
    );
  }

  Widget showLoadingScreen() {
    return Loading();
  }

  Widget showNoDataScreen() {
    return WidgetEnterAnimation(
      delay: 1,
      child: NoData(),
    );
  }
}
