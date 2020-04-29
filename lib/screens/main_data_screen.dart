import 'package:covid19_tracker/services/networking.dart';
import 'package:covid19_tracker/widgets/StateData.dart';
import 'package:covid19_tracker/widgets/custom_card.dart';
import 'package:covid19_tracker/widgets/custom_heading.dart';
import 'package:covid19_tracker/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MainDataScreen extends StatefulWidget {
  @override
  _MainDataScreenState createState() => _MainDataScreenState();
}

class _MainDataScreenState extends State<MainDataScreen> {
  dynamic countryData;

  dynamic activeCases;
  dynamic deaths;
  dynamic last_updated;
  bool _isData = true;
  List<StateData> stateList = [];

  dynamic recovered;
  List<Widget> displayLiveData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryData();
    getStateData();
  }

  void getCountryData() async {
    NetworkHelper country = NetworkHelper(
        url: 'https://covid-19india-api.herokuapp.com/v2.0/country_data');
    countryData = await country.getData();

    if (countryData == null) {
      print('unable to fetch data');
    } else {
      setState(() {
        activeCases = countryData['active_cases'];
        deaths = countryData['death_cases'];
        recovered = countryData['recovered_cases'];
        last_updated = countryData['last_updated'];
      });
    }
  }

  void getStateData() async {
    NetworkHelper state = NetworkHelper(
        url: 'https://covid-19india-api.herokuapp.com/v2.0/state_data');
    var stateData = await state.getData();

    if (stateData == null) {
      print('Unable to fetch state data');
    } else {
      var stateReccord = stateData['state_data'];
      for (var record in stateReccord) {
        stateList.add(StateData(
            stateName: record['State'],
            confirmed: record['Confirmed'],
            deaths: record['Death'],
            recovered: record['Cured']));
      }
      setState(() {
        _isData = false;
        displayLiveData = getListViewData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isData,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          'assets/virus1_white.png',
                          height: 100,
                          width: 100,
                          alignment: Alignment.topRight,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Covid-19',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '#India',
                        style: TextStyle(color: Colors.orange, fontSize: 20.0),
                      ),
                      Text(
                        'Fights',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      Text(
                        'Corona',
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      )
                    ],
                  )),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              height: MediaQuery.of(context).size.height / 3.5,
              width: double.infinity,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'As updated on $last_updated',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomCard(
                  title: 'Active Cases',
                  count: activeCases.toString(),
                  titleColor: Colors.black54,
                  icon: Icons.search,
                ),
                CustomCard(
                  title: 'Deaths',
                  count: deaths.toString(),
                  titleColor: Colors.red,
                  icon: FontAwesomeIcons.frown,
                ),
                CustomCard(
                  title: 'Recovered',
                  count: recovered.toString(),
                  titleColor: Colors.green,
                  icon: FontAwesomeIcons.smile,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      'State/U.T.',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomHeading(title: 'Confirmed'),
                  CustomHeading(title: 'Recovered'),
                  CustomHeading(title: 'Deaths'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 800.0,
                width: double.infinity,
                // color: Colors.black,
                child: ListView(
                  children: displayLiveData,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getListViewData() {
    List<Widget> listData = [];

    for (StateData i in stateList) {
      listData.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  i.stateName,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              CustomListItem(
                title: i.confirmed,
              ),
              CustomListItem(
                title: i.recovered,
              ),
              CustomListItem(
                title: i.deaths,
              ),
            ],
          ),
        ),
      );
    }

    return listData;
  }
}
