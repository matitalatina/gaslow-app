import 'package:gaslow_app/redux/CoreState.dart';
import 'package:gaslow_app/redux/LocationState.dart';
import 'package:meta/meta.dart';

import 'RouteState.dart';
import 'SettingsState.dart';

class AppState {
  LocationState stationsState;
  CoreState backendState;
  RouteState routeState;
  SettingsState settingsState;
  AppState({
    @required this.stationsState,
    @required this.backendState,
    @required this.routeState,
    @required this.settingsState,
  });
}