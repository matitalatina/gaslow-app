import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/redux/FavoriteState.dart';
import 'package:gaslow_app/redux/actions/FavoriteStationsActions.dart';

FavoriteState favoriteReducer(FavoriteState state, dynamic action) {
  if (action is FavoriteStationsUpdate) {
    final stationIds = action.stations.map((e) => e.id).toSet();
    return FavoriteState(
        isLoading: false,
        stationIds: stationIds,
        stations: action.stations,
        selectedStation: stationIds.contains(state.selectedStation)
            ? state.selectedStation
            : null,
        error: state.error);
  }
  if (action is FavoriteFetchStationsStart) {
    return FavoriteState(
        isLoading: true,
        stationIds: state.stationIds,
        stations: state.stations,
        selectedStation: state.selectedStation,
        error: ErrorType.NONE);
  }
  if (action is FavoriteFetchStationsSuccess) {
    return FavoriteState(
        isLoading: false,
        stationIds: action.stations.map((s) => s.id).toSet(),
        stations: action.stations,
        selectedStation: state.selectedStation,
        error: ErrorType.NONE);
  }
  if (action is FavoriteFetchStationsError) {
    return FavoriteState(
        isLoading: false,
        stationIds: state.stationIds,
        stations: state.stations,
        selectedStation: state.selectedStation,
        error: ErrorType.CONNECTION);
  }
  else if (action is FavoriteSelectStationAction) {
    return FavoriteState(
        isLoading: state.isLoading,
        stationIds: state.stationIds,
        stations: state.stations,
        selectedStation: action.stationId,
        error: state.error);
  }
  return state;
}
