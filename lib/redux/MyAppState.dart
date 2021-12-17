import 'package:gaslow_app/redux/CoreState.dart';
import 'package:gaslow_app/redux/FavoriteState.dart';
import 'package:gaslow_app/redux/LocationState.dart';

import 'RouteState.dart';
import 'SettingsState.dart';

class MyAppState {
  final CoreState backendState;
  final LocationState stationsState;
  final RouteState routeState;
  final FavoriteState favoriteState;
  final SettingsState settingsState;

  MyAppState({
    required this.backendState,
    required this.stationsState,
    required this.routeState,
    required this.favoriteState,
    required this.settingsState,
  });
}