import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/redux/MyAppState.dart';
import 'package:gaslow_app/redux/CoreState.dart';
import 'package:gaslow_app/redux/FavoriteState.dart';
import 'package:gaslow_app/redux/LocationState.dart';
import 'package:gaslow_app/redux/RouteState.dart';
import 'package:gaslow_app/redux/SettingsState.dart';
import 'package:gaslow_app/redux/actions/CoreActions.dart';
import 'package:gaslow_app/redux/reducers/AppStateReducer.dart';
import 'package:gaslow_app/services/AdService.dart';
import 'package:gaslow_app/widgets/pages/TabsPage.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Future<Store<MyAppState>> prepareStore() async {
  final store = Store<MyAppState>(
    appReducer,
    initialState: new MyAppState(
      backendState: getDefaultCoreState(),
      favoriteState: await getDefaultFavoriteState(),
      routeState: getDefaultRouteState(),
      settingsState: await getDefaultSettingsState(),
      stationsState: getDefaultStationsState(),
    ),
    middleware: [thunkMiddleware],
  );
  store.dispatch(checkLocationPermissionAndFetchStations);
  return store;
}

Future<void> main() async {
  // https://github.com/flutter/flutter/issues/38056
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServiceLocator();
  getIt<AdService>().initialize();
  runApp(FutureBuilder<Store<MyAppState>>(
      future: prepareStore(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return MyApp(store: snapshot.data!);
      }));
}

class MyApp extends StatelessWidget {
  final Store<MyAppState> store;

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
    final color = allowedColors[Random(DateTime.now().millisecondsSinceEpoch)
        .nextInt(allowedColors.length)];
    final theme = new ThemeData(
      primarySwatch: color,
      fontFamily: 'WorkSans',
    );
    return StoreProvider<MyAppState>(
        store: store,
        child: new MaterialApp(
          title: 'GasLow',
          theme: theme.copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: color),
            floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
              backgroundColor: color.shade50,
            ),
          ),
          home: TabsPage(),
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: getIt<FirebaseAnalytics>()),
          ],
        ));
  }

  MyApp({Key? key, required this.store}) : super(key: key);
}
