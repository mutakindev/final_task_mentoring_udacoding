import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/onboarding.dart';
import 'package:parawisata_mutakin/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
