import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/actions/RouteStationsActions.dart';

import '../RouteState.dart';

RouteState routeReducer(RouteState state, action) {
  if (action is RouteFetchStationsSuccess) {
    return RouteState(
      isLoading: false,
      stations: List<GasStation>.from(action.stations),
      fromLocation: state.fromLocation,
      toLocation: state.toLocation,
      selectedStation: state.selectedStation,
      error: state.error,
    );
  } else if (action is RouteFetchStationsStart) {
    return RouteState(
      isLoading: true,
      stations: state.stations,
      fromLocation: state.fromLocation,
      toLocation: state.toLocation,
      selectedStation: null,
      error: ErrorType.NONE,
    );
  } else if (action is RouteUpdateFromLocation) {
    return RouteState(
      isLoading: state.isLoading,
      stations: state.stations,
      fromLocation: action.fromLocation,
      toLocation: state.toLocation,
      selectedStation: state.selectedStation,
      error: state.error,
    );
  } else if (action is RouteUpdateToLocation) {
    return RouteState(
      isLoading: state.isLoading,
      stations: state.stations,
      fromLocation: state.fromLocation,
      toLocation: action.toLocation,
      selectedStation: state.selectedStation,
      error: state.error,
    );
  } else if (action is RouteSelectStationAction) {
    return RouteState(
      isLoading: state.isLoading,
      stations: state.stations,
      fromLocation: state.fromLocation,
      toLocation: state.toLocation,
      selectedStation: action.stationId,
      error: state.error,
    );
  } else if (action is RouteFetchStationsError) {
    return RouteState(
      isLoading: false,
      stations: state.stations,
      fromLocation: state.fromLocation,
      toLocation: state.toLocation,
      selectedStation: state.selectedStation,
      error: action.error,
    );
  }
  return RouteState(
    isLoading: state.isLoading,
    stations: state.stations,
    fromLocation: state.fromLocation,
    toLocation: state.toLocation,
    selectedStation: state.selectedStation,
    error: state.error,
  );
}
