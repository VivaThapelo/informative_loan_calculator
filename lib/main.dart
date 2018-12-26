import 'package:flutter/material.dart';

import 'Loan.dart';
import 'MyAnnuityPage.dart';
import 'MyHomePage.dart';

const int ANNUITY = 0, DIFFERENTIATED = 1, FIXED_PAYMENTS = 2;
Loan loaned = new Loan();
int downType = 0,
    lastType = 0,
    monthlyType = 0,
    disposableType = 0;
int selectedLoan = 0, selectedInterestType = 0;
int periodMonths = 0,
    periodYears = 0,
    period = 0;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Informative Loan Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        primaryColorBrightness: Brightness.light,
        backgroundColor: Colors.grey.shade900,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/MyAnnuityPage": (context) => MyAnnuityPage(),
      },
    );
  }
}