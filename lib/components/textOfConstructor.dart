import 'package:flutter/material.dart';

class MyCustomText extends StatelessWidget {
  String text;
  bool isBigText;
  MyCustomText({super.key, required this.text, required this.isBigText});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: isBigText ? FontWeight.bold : FontWeight.normal,
          fontSize: isBigText ? 20 : 14),
    );
  }
}
