import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/StationsState.dart';
import 'package:gaslow_app/redux/actions/FetchStations.dart';

StationsState stationReducer(StationsState state, action) {
  if (action is FetchStationByLocationSuccess) {
    return StationsState(
      isLoading: false,
      stations: List<GasStation>.from(action.stations),
    );
  } else if (action is FetchStationByLocationStart) {
    return StationsState(
      isLoading: true,
      stations: List<GasStation>.from(state.stations),
    );
  }
  return StationsState(
    isLoading: state.isLoading,
    stations: List<GasStation>.from(state.stations),
  );
}
