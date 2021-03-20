import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/plants.dart';
import 'package:parawisata_mutakin/ui/wisata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: WisataPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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