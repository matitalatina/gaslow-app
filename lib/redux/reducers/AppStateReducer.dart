import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/reducers/BackendReducer.dart';
import 'package:gaslow_app/redux/reducers/LocationReducer.dart';

import 'RouteReducer.dart';

AppState appReducer(AppState state, dynamic action) => new AppState(
  stationsState: locationReducer(state.stationsState, action),
  backendState: backendReducer(state.backendState, action),
  routeState: routeReducer(state.routeState, action),
);