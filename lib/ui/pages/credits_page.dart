import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:covid_19/ui/widgets/credits_page_header.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.grey[50],
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  CreditsPageHeader(
                    titleName: "#IndiaFightsCorona",
                  ),
                  Container(
                    child: Text("Credits Page"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
