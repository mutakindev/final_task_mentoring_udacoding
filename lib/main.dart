import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/plants.dart';
import 'package:parawisata_mutakin/ui/wisata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Task',
      home: MainApp(),
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

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int index = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            this.index = index;
          });
        },
        controller: pageController,
        children: [
          Plants(),
          WisataPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            pageController.jumpToPage(value);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_business_outlined), label: 'Plant'),
          BottomNavigationBarItem(
              icon: Icon(Icons.place_outlined), label: 'Wisata')
        ],
      ),
    );
  }
}
