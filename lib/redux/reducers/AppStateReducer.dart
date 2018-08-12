import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/reducers/BackendReducer.dart';
import 'package:gaslow_app/redux/reducers/StationsReducer.dart';

AppState appReducer(AppState state, dynamic action) => new AppState(
  stationsState: stationReducer(state.stationsState, action),
  backendState: backendReducer(state.backendState, action),
);