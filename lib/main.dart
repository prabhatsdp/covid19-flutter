import 'package:covid_19/ui/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        fontFamily: "Niramit",
        primaryColorDark: Color(0xFFFFA286),
        accentColor: Color(0xFFA5EACF),
        primaryColor: Color(0xFFFCDCC8),
        primaryColorLight: Color(0xFFFFF4F2),
        // scaffoldBackgroundColor: Colors.black.withBlue(50),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
