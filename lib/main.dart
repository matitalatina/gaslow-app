import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/pages/TabsPage.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/CoreState.dart';
import 'package:gaslow_app/redux/LocationState.dart';
import 'package:gaslow_app/redux/RouteState.dart';
import 'package:gaslow_app/redux/SettingsState.dart';
import 'package:gaslow_app/redux/actions/CoreActions.dart';
import 'package:gaslow_app/redux/reducers/AppStateReducer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


Future<Store<AppState>> prepareStore() async {
  final store = Store<AppState>(
    appReducer,
    initialState: new AppState(
      stationsState: getDefaultStationsState(),
      backendState: getDefaultCoreState(),
      routeState: getDefaultRouteState(),
      settingsState: await getDefaultSettingsState(),
    ),
    middleware: [thunkMiddleware],
  );
  store.dispatch(checkLocationPermissionAndFetchStations);
  return store;
}

void main() {
  // https://github.com/flutter/flutter/issues/38056
  WidgetsFlutterBinding.ensureInitialized();
  initializeServiceLocator();
  MobileAds.instance.initialize();
  runApp(FutureBuilder<Store<AppState>>(
      future: prepareStore(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
      return MyApp(store: snapshot.data!);
  }));
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
            Random(DateTime
                .now()
                .millisecondsSinceEpoch)
                .nextInt(allowedColors.length)],
            fontFamily: 'WorkSans',
          ),
          home: TabsPage(),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: getIt<FirebaseAnalytics>()),
          ],
        ));
  }

  MyApp({Key? key, required this.store}) : super(key: key);
}
