import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/MyLocation.dart';
import 'package:gaslow_app/redux/MyAppState.dart';
import 'package:gaslow_app/clients/StationsClient.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as Loc;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class LocationFetchStationsSuccess {
  final List<GasStation> stations;

  LocationFetchStationsSuccess({required this.stations});
}

class LocationFetchStationsError {
  final ErrorType error;

  LocationFetchStationsError({required this.error});
}

class LocationFetchStationsStart {}

class LocationUpdateFromLocation {
  final MyLocation fromLocation;

  LocationUpdateFromLocation({required this.fromLocation});
}

class LocationSelectStationAction {
  final int stationId;

  LocationSelectStationAction({required this.stationId});
}

fetchStationsByCurrentLocationAction(Store<MyAppState> store) async {
  store.dispatch(LocationFetchStationsStart());
  Loc.LocationData currentLocationRaw = await getIt.get<Loc.Location>().getLocation();
  if (currentLocationRaw.latitude == null ||
      currentLocationRaw.longitude == null) {
    store.dispatch(
        new LocationFetchStationsError(error: ErrorType.MY_POSITION_FAILED));
    return;
  }
  final currentLocation = MyLocation.fromPoint(
    latitude: currentLocationRaw.latitude!,
    longitude: currentLocationRaw.longitude!,
  );

  store.dispatch(new LocationUpdateFromLocation(fromLocation: currentLocation));

  try {
    store.dispatch(new LocationFetchStationsSuccess(
        stations: await StationsClient().getStationsByCoords(
      latitude: currentLocationRaw.latitude!,
      longitude: currentLocationRaw.longitude!,
    )));
  } catch (e) {
    store.dispatch(new LocationFetchStationsError(error: ErrorType.CONNECTION));
  }
}

ThunkAction<MyAppState> fetchStationsByPlaceNameAction(String name) {
  return (Store<MyAppState> store) async {
    final analytics = getIt<FirebaseAnalytics>();
    await analytics.logSearch(
      searchTerm: 'Location',
      destination: name,
    );
    store.dispatch(LocationFetchStationsStart());
    try {
      var firstAddress = (await locationFromAddress(name)).first;
      store.dispatch(new LocationUpdateFromLocation(
          fromLocation: MyLocation.fromPoint(
        latitude: firstAddress.latitude,
        longitude: firstAddress.longitude,
      )));

      store.dispatch(new LocationFetchStationsSuccess(
          stations: await StationsClient().getStationsByCoords(
        latitude: firstAddress.latitude,
        longitude: firstAddress.longitude,
      )));
    } on NoResultFoundException catch (_) {
      store.dispatch(
          new LocationFetchStationsError(error: ErrorType.GEOCODING_FAILED));
    } catch (_) {
      store.dispatch(
          new LocationFetchStationsError(error: ErrorType.CONNECTION));
    }
  };
}
