import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseWisataImageUrl = "https://flutter-task4.000webhostapp.com/storage";
const basePlantImageUrl = "https://flutter-task4.000webhostapp.com/api/upload";
SharedPreferences sharedPreferences;

Future<void> initSharedPref() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

void showSnackbarMessage(BuildContext context, String s) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(s),
      backgroundColor: Colors.pink,
      duration: Duration(milliseconds: 700),
      margin: EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating));
}
