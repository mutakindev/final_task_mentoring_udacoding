import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/plants.dart';
import 'package:parawisata_mutakin/ui/wisata.dart';

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
