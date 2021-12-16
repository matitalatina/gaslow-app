import 'package:gaslow_app/redux/CoreState.dart';
import 'package:gaslow_app/redux/FavoriteState.dart';
import 'package:gaslow_app/redux/LocationState.dart';

import 'RouteState.dart';
import 'SettingsState.dart';

class AppState {
  final CoreState backendState;
  final LocationState stationsState;
  final RouteState routeState;
  final FavoriteState favoriteState;
  final SettingsState settingsState;

  AppState({
    required this.backendState,
    required this.stationsState,
    required this.routeState,
    required this.favoriteState,
    required this.settingsState,
  });
}