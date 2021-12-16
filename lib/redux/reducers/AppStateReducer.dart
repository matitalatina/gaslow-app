import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/reducers/CoreReducer.dart';
import 'package:gaslow_app/redux/reducers/FavoriteReducer.dart';
import 'package:gaslow_app/redux/reducers/LocationReducer.dart';
import 'package:gaslow_app/redux/reducers/SettingsReducer.dart';

import 'RouteReducer.dart';

AppState appReducer(AppState state, dynamic action) => new AppState(
  stationsState: locationReducer(state.stationsState, action),
  backendState: coreReducer(state.backendState, action),
  favoriteState: favoriteReducer(state.favoriteState, action),
  routeState: routeReducer(state.routeState, action),
  settingsState: settingsReducer(state.settingsState, action),
);