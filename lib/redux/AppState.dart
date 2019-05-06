import 'package:gaslow_app/redux/CoreState.dart';
import 'package:gaslow_app/redux/LocationState.dart';

import 'RouteState.dart';

class AppState {
  LocationState stationsState;
  CoreState backendState;
  RouteState routeState;
  AppState({this.stationsState, this.backendState, this.routeState});
}