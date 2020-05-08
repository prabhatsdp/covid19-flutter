import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/ui/widgets/pageheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatePage extends StatelessWidget {
  final String title;
  final MyStateData stateData;
  const StatePage({Key key, @required this.title, @required this.stateData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                        child: PageHeader(title: title),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
