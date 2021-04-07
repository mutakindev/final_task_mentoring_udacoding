import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/auth/login.dart';
import 'package:parawisata_mutakin/ui/splash_screen.dart';
import 'package:parawisata_mutakin/utils.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFCE7),
      body: Column(
        children: [
          Image.asset(
            'assets/icon.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontWeight: FontWeight.bold, color: Colors.green.shade400),
          ),
          Text(
            'Plants And Tourist adalah aplikasi daftar tempat wisata dan juga Tumbuhan hias, aplikasi ini menyediakan informasi informasi sederhana tentang tumbuhan dan juga tempat wisata diindonesia.\nAplikasi ini dibuat untuk memenuhi tugas dari udacoding sebagai prasyarat lulus program mentoring Flutter batch 4.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.grey.shade500,
                height: 1.5,
                letterSpacing: 0.8,
                shadows: [Shadow()]),
          ),
          Padding(
            padding: EdgeInsets.all(16).add(EdgeInsets.only(top: 25)),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              minWidth: double.infinity,
              height: 50,
              color: Colors.green.shade400,
              textColor: Colors.white,
              onPressed: () async {
                await initSharedPref();
                await sharedPreferences.setBool('isFirstLaunch', false);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Mulai Sekarang',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
