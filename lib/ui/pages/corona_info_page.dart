import 'package:flutter/material.dart';

class CoronaInfoPage extends StatelessWidget {
  const CoronaInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text("Corona Info Page"),
          ),
        ),
      ),
    );
  }
}
