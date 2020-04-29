import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String title;

  CustomListItem({this.title});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Text(
      title,
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
    ));
  }
}
