import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String title;

  CustomHeading({this.title});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
    ));
  }
}
