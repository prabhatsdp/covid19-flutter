import 'package:covid_19/bloc/statewise_bloc.dart';
import 'package:covid_19/data/models/summary.dart';
import 'package:covid_19/ui/widgets/loading.dart';
import 'package:covid_19/ui/widgets/no_data.dart';
import 'package:covid_19/ui/widgets/summarycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndiaDetails extends StatelessWidget {
  final List<Summary> summaryList;

  IndiaDetails({@required this.summaryList});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatewiseBloc, StatewiseState>(
      
      builder: (context, state) {
        if (state is StatewiseInitial) {
          return showLoadingScreen();
        } else if (state is StatewiseLoaded) {
          return showIndiaDetails();
        } else if (state is StatewiseError) {
          return showNoDataScreen();
        }
        return null;
      },
    );
  }

  Widget showIndiaDetails() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: SummaryCard(
                  name: summaryList[0].name,
                  value: summaryList[0].value,
                ),
              ),
              Expanded(
                child: SummaryCard(
                  name: summaryList[1].name,
                  value: summaryList[1].value,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SummaryCard(
                  name: summaryList[2].name,
                  value: summaryList[2].value,
                ),
              ),
              Expanded(
                child: SummaryCard(
                  name: summaryList[3].name,
                  value: summaryList[3].value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showLoadingScreen() {
    return Loading();
  }

  Widget showNoDataScreen() {
    return NoData();
  }
}
