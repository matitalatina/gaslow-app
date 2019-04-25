import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/StationsState.dart';
import 'package:gaslow_app/redux/actions/FetchStations.dart';
import 'package:gaslow_app/redux/actions/UiStations.dart';
import 'package:gaslow_app/redux/selectors/StationsSelectors.dart';
import 'package:gaslow_app/widgets/MapWidget.dart';
import 'package:gaslow_app/widgets/SearchField.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:gaslow_app/widgets/StationsWidget.dart';

import 'LocationPage.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 1;
  final _widgetOptions = [
    LocationPage(title: 'GasLow'),
    Text('Index 1: Business'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.location_on), title: Text('Posizione')),
          BottomNavigationBarItem(icon: Icon(Icons.near_me), title: Text('Viaggio')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}