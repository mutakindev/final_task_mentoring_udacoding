import 'package:flutter/material.dart';

const baseWisataImageUrl = "https://flutter-task4.000webhostapp.com/storage";
const basePlantImageUrl = "https://flutter-task4.000webhostapp.com/api/upload";

void showSnackbarMessage(BuildContext context, String s) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(s),
    backgroundColor: Colors.pink,
  ));
}
