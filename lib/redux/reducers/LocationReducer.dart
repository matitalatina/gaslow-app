import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/LocationState.dart';
import 'package:gaslow_app/redux/actions/LocationStationsActions.dart';

LocationState locationReducer(LocationState state, action) {
  if (action is LocationFetchStationsSuccess) {
    return LocationState(
      isLoading: false,
      stations: List<GasStation>.from(action.stations),
      fromLocation: state.fromLocation,
      selectedStation: state.selectedStation,
    );
  } else if (action is LocationFetchStationsStart) {
    return LocationState(
      isLoading: true,
      stations: List<GasStation>.from(state.stations),
      fromLocation: state.fromLocation,
      selectedStation: null,
    );
  } else if (action is LocationUpdateFromLocation) {
    return LocationState(
      isLoading: state.isLoading,
      stations: state.stations,
      fromLocation: action.fromLocation,
      selectedStation: state.selectedStation,
    );
  } else if (action is LocationSelectStationAction) {
    return LocationState(
      isLoading: state.isLoading,
      stations: state.stations,
      fromLocation: state.fromLocation,
      selectedStation: action.stationId,
    );
  }
  return LocationState(
    isLoading: state.isLoading,
    stations: List<GasStation>.from(state.stations),
    fromLocation: state.fromLocation,
    selectedStation: state.selectedStation,
  );
}
