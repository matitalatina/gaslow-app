import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/StationsState.dart';
import 'package:gaslow_app/redux/actions/FetchStations.dart';

StationsState stationReducer(StationsState state, action) {
  if (action is FetchStationSuccess) {
    return StationsState(
      isLoading: false,
      stations: List<GasStation>.from(action.stations),
      fromLocation: state.fromLocation,
    );
  } else if (action is FetchStationStart) {
    return StationsState(
      isLoading: true,
      stations: List<GasStation>.from(state.stations),
      fromLocation: state.fromLocation,
    );
  } else if (action is UpdateFromLocation) {
    return StationsState(
      isLoading: state.isLoading,
      stations: state.stations,
      fromLocation: action.fromLocation,
    );
  }
  return StationsState(
    isLoading: state.isLoading,
    stations: List<GasStation>.from(state.stations),
    fromLocation: state.fromLocation,
  );
}
