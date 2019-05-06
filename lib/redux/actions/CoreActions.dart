import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/actions/LocationStationsActions.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:redux/redux.dart';

class UpdateStationsSuccess {}

class UpdateStationsStart {}

class UpdateLocationPermission {
  final bool hasLocationPermission;

  UpdateLocationPermission({this.hasLocationPermission});
}

// ignore: strong_mode_top_level_function_literal_block
final updateStationsAction = (Store<AppState> store) async {
  store.dispatch(UpdateStationsStart());
  await post("https://gaslow.herokuapp.com/stations/update");
  store.dispatch(UpdateStationsSuccess());
};

checkLocationPermissionAndFetchStations(Store<AppState> store) async {
  bool hasLocationPermission = await requestLocationPermission(store);
  if (hasLocationPermission) {
    await fetchStationsByCurrentLocationAction(store);
  }
}

Future<bool> requestLocationPermission(Store<AppState> store) async {
  Location location = new Location();
  bool hasLocationPermission = await location.hasPermission();
  if (!hasLocationPermission) {
    hasLocationPermission = await location.requestPermission();
  }
  store.dispatch(UpdateLocationPermission(hasLocationPermission: hasLocationPermission));
  return hasLocationPermission;
}