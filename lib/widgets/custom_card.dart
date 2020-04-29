import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String count;
  final String title;
  final Color titleColor;
  final IconData icon;
  CustomCard({this.title, this.count, this.titleColor, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 15.0, fontWeight: FontWeight.bold, color: titleColor),
          ),
          Icon(
            icon,
            color: titleColor,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            count.toString(),
            style: TextStyle(
                fontSize: 15.0, fontWeight: FontWeight.bold, color: titleColor),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
