import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/onboarding.dart';
import 'package:parawisata_mutakin/ui/splash_screen.dart';
import 'package:parawisata_mutakin/ui/wisata.dart';
import 'package:parawisata_mutakin/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> buildPage() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    bool isNewInstalled = sharedpref.getBool('first_launch');

    if (isNewInstalled == null) {
      sharedPreferences.setBool('first_launch', true);
    } else if (isNewInstalled == false) {
      return SplashScreen();
    } else {
      return OnboardingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant & Tourist',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Montserrat',
        accentColor: Colors.orange,
        textTheme: TextTheme(
                bodyText1: TextStyle(),
                bodyText2: TextStyle(),
                subtitle1: TextStyle(),
                caption: TextStyle(),
                headline6: TextStyle())
            .apply(
          bodyColor: Color(0xFF0D0D0B),
          displayColor: Colors.blue,
        ),
      ),
    );
  }
}
