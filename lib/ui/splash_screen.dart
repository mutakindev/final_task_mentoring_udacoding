import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/auth/login.dart';
import 'package:parawisata_mutakin/ui/main_app.dart';
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
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "",
                width: 100,
                height: 100,
              ),
              Text(
                "Plants & Tourist",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.brown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Timer> startTimer() async {
    return Timer(Duration(seconds: 2), onDone);
  }

  void onDone() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int value = sharedPreferences.getInt("value");
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => value == 1 ? MainApp() : LoginPage()));
  }
}
