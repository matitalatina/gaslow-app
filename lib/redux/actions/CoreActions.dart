import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/redux/MyAppState.dart';
import 'package:gaslow_app/redux/actions/LocationStationsActions.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:redux/redux.dart';

import '../../locator.dart';

class UpdateStationsSuccess {}

class UpdateStationsStart {}

class UpdateLocationPermission {
  final bool hasLocationPermission;

  UpdateLocationPermission({required this.hasLocationPermission});
}

// ignore: strong_mode_top_level_function_literal_block
final updateStationsAction = (Store<MyAppState> store) async {
  store.dispatch(UpdateStationsStart());
  await post(Uri.parse("https://gaslow.herokuapp.com/stations/update"));
  store.dispatch(UpdateStationsSuccess());
};

checkLocationPermissionAndFetchStations(Store<MyAppState> store) async {
  bool hasLocationPermission = await requestLocationPermission(store);
  if (hasLocationPermission) {
    await fetchStationsByCurrentLocationAction(store);
  }
}

Future<bool> requestLocationPermission(Store<MyAppState> store) async {
  Location location = getIt.get<Location>();
  bool _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      store.dispatch(new LocationFetchStationsError(error: ErrorType.MY_POSITION_FAILED));
      return false;
    }
  }
  PermissionStatus hasLocationPermission = await location.hasPermission();
  bool hasPermission = (hasLocationPermission == PermissionStatus.granted || hasLocationPermission == PermissionStatus.grantedLimited);
  if (!hasPermission) {
    hasLocationPermission = await location.requestPermission();
  }
  store.dispatch(UpdateLocationPermission(hasLocationPermission: hasPermission));
  return hasPermission;
}
