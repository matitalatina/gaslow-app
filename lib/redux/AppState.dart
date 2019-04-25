import 'package:gaslow_app/redux/BackendState.dart';
import 'package:gaslow_app/redux/LocationState.dart';

import 'RouteState.dart';

class AppState {
  LocationState stationsState;
  BackendState backendState;
  RouteState routeState;
  AppState({this.stationsState, this.backendState, this.routeState});
}