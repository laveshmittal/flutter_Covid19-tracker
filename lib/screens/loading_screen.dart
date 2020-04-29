import 'dart:async';

import 'package:covid19_tracker/screens/main_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = new Timer(const Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainDataScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                height: 200,
                width: 200,
                image: AssetImage(
                  'assets/virus1.png',
                ),
              ),
            ),
            SpinKitThreeBounce(
              color: Colors.red.shade600,
              size: 20.0,
            )
          ],
        ),
      ),
    );
  }
}

void getData() {}
