import 'package:gaslow_app/redux/MyAppState.dart';
import 'package:gaslow_app/redux/reducers/CoreReducer.dart';
import 'package:gaslow_app/redux/reducers/FavoriteReducer.dart';
import 'package:gaslow_app/redux/reducers/LocationReducer.dart';
import 'package:gaslow_app/redux/reducers/SettingsReducer.dart';

import 'RouteReducer.dart';

MyAppState appReducer(MyAppState state, dynamic action) => new MyAppState(
  stationsState: locationReducer(state.stationsState, action),
  backendState: coreReducer(state.backendState, action),
  favoriteState: favoriteReducer(state.favoriteState, action),
  routeState: routeReducer(state.routeState, action),
  settingsState: settingsReducer(state.settingsState, action),
);