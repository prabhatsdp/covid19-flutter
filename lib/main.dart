import 'package:covid_19/services/analytics.dart';
import 'package:covid_19/ui/pages/homepage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  FirebaseAnalytics analytics = AnalyticsService().getAnalytics();
  FirebaseAnalyticsObserver analyticsObserver = AnalyticsService().getAnalyticsObserver();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[
        analyticsObserver,
      ],
      title: 'Covid 19 India',
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
