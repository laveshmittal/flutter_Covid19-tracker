import 'package:flutter/material.dart';

class StateData {
  String stateName;
  String confirmed;
  String deaths;
  String recovered;

  StateData({this.stateName, this.confirmed, this.recovered, this.deaths});

  Widget getInfo() {
    return Row(
      children: <Widget>[
        Text(stateName),
        Text(confirmed),
        Text(deaths),
        Text(recovered),
      ],
    );
  }
}
