import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/auth/login.dart';
import 'package:parawisata_mutakin/ui/main_app.dart';
import 'package:parawisata_mutakin/ui/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFCE7),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon.png',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              Text(
                "Plants & Tourist",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Timer> startTimer() async {
    return Timer(Duration(seconds: 3), onDone);
  }

  void onDone() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences.getBool('isFirstLaunch');

    if (isFirstLaunch == null) {
      await sharedPreferences.setBool('isFirstLaunch', true);
      isFirstLaunch = true;
    }

    int value = sharedPreferences.getInt("value");
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => isFirstLaunch
            ? OnboardingPage()
            : value == 1
                ? MainApp()
                : LoginPage()));
  }
}
