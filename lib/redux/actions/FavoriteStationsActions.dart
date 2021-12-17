import 'package:gaslow_app/clients/StationsClient.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/MyAppState.dart';
import 'package:gaslow_app/services/FavoriteService.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class FavoriteFetchStationsSuccess {
  final Set<GasStation> stations;

  FavoriteFetchStationsSuccess({required this.stations});
}

class FavoriteFetchStationsError {
  final ErrorType error;

  FavoriteFetchStationsError({required this.error});
}

class FavoriteFetchStationsStart {}

class FavoriteSelectStationAction {
  final int stationId;

  FavoriteSelectStationAction({required this.stationId});
}

class FavoriteStationsUpdate {
  final Set<GasStation> stations;

  FavoriteStationsUpdate({required this.stations});
}

refreshFavoriteLocations(Store<MyAppState> store) async {
  final favoriteService = getIt<FavoriteService>();
  store.dispatch(FavoriteFetchStationsStart());
  try {
    final stations =
        await StationsClient().getByIds(store.state.favoriteState.stationIds);
    favoriteService.setFavoriteStations(stations.map((s) => s.id).toSet());
    store.dispatch(FavoriteFetchStationsSuccess(stations: stations.toSet()));
  } catch (e) {
    store.dispatch(FavoriteFetchStationsError(error: ErrorType.CONNECTION));
  }
}

ThunkAction<MyAppState> addFavoriteStation(GasStation station) {
  return (Store<MyAppState> store) async {
    final favoriteService = getIt<FavoriteService>();
    await favoriteService.addFavoriteStation(station.id);
    final updatedStations = Set<GasStation>.from(store.state.favoriteState.stations)
      ..add(station);
    store.dispatch(FavoriteStationsUpdate(stations: updatedStations));
  };
}

ThunkAction<MyAppState> removeFavoriteStation(int stationId) {
  return (Store<MyAppState> store) async {
    final favoriteService = getIt<FavoriteService>();
    await favoriteService.removeFavoriteStation(stationId);
    final updatedStations = Set<GasStation>.from(store.state.favoriteState.stations)
      ..removeWhere((s) => s.id == stationId);
    store.dispatch(FavoriteStationsUpdate(stations: updatedStations));
  };
}
