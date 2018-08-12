import 'package:gaslow_app/redux/BackendState.dart';
import 'package:gaslow_app/redux/StationsState.dart';

class AppState {
  StationsState stationsState;
  BackendState backendState;
  AppState({this.stationsState, this.backendState});
}