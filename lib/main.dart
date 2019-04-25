import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/pages/LocationPage.dart';
import 'package:gaslow_app/pages/TabsPage.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/BackendState.dart';
import 'package:gaslow_app/redux/StationsState.dart';
import 'package:gaslow_app/redux/actions/FetchStations.dart';
import 'package:gaslow_app/redux/reducers/AppStateReducer.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: new AppState(
        stationsState: StationsState(
            isLoading: false,
            stations: [],
            fromLocation: null,
            selectedStation: null),
        backendState: BackendState(isLoading: false),
      ));
  store.dispatch(fetchStationsByLocationAction(store));
  runApp(new MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<MaterialColor> allowedColors = [
      Colors.indigo,
      Colors.red,
      Colors.cyan,
      Colors.blue,
      Colors.purple,
      Colors.teal,
      Colors.green,
      Colors.amber,
      Colors.orange,
      Colors.lightGreen,
      Colors.lightBlue,
      Colors.pink,
      Colors.lime,
    ];
    return StoreProvider<AppState>(
        store: store,
        child: new MaterialApp(
          title: 'GasLow',
          theme: new ThemeData(
            primarySwatch: allowedColors[
                Random(DateTime.now().millisecondsSinceEpoch)
                    .nextInt(allowedColors.length)],
            fontFamily: 'WorkSans',
          ),
          home: TabsPage(),
        ));
  }

  MyApp({Key key, this.store}) : super(key: key);
}
