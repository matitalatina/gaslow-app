import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/services/StationsClient.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart' as Loc;
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class LocationFetchStationsSuccess {
  final List<GasStation> stations;

  LocationFetchStationsSuccess({this.stations});
}

class LocationFetchStationsError {
  final ErrorType error;

  LocationFetchStationsError({this.error});
}

class LocationFetchStationsStart {}

class LocationUpdateFromLocation {
  final Location fromLocation;

  LocationUpdateFromLocation({@required this.fromLocation});
}

class LocationSelectStationAction {
  final int stationId;

  LocationSelectStationAction({@required this.stationId});
}

fetchStationsByCurrentLocationAction(Store<AppState> store) async {
  store.dispatch(LocationFetchStationsStart());
  Loc.LocationData currentLocationRaw = await new Loc.Location().getLocation();
  final currentLocation = Location.fromPoint(
    latitude: currentLocationRaw.latitude,
    longitude: currentLocationRaw.longitude,
  );

  store.dispatch(new LocationUpdateFromLocation(fromLocation: currentLocation));

  try {
    store.dispatch(new LocationFetchStationsSuccess(
        stations: await StationsClient().getStationsByCoords(
      latitude: currentLocationRaw.latitude,
      longitude: currentLocationRaw.longitude,
    )));
  } catch (e) {
    store.dispatch(new LocationFetchStationsError(error: ErrorType.CONNECTION));
  }
}

ThunkAction<AppState> fetchStationsByPlaceNameAction(String name) {
  return (Store<AppState> store) async {
    final analytics = getIt<FirebaseAnalytics>();
    await analytics.logSearch(
      searchTerm: 'Location',
      destination: name,
    );
    store.dispatch(LocationFetchStationsStart());
    Address firstAddress =
        (await Geocoder.local.findAddressesFromQuery(name)).first;

    store.dispatch(new LocationUpdateFromLocation(
        fromLocation: Location.fromPoint(
      latitude: firstAddress.coordinates.latitude,
      longitude: firstAddress.coordinates.longitude,
    )));

    store.dispatch(new LocationFetchStationsSuccess(
        stations: await StationsClient().getStationsByCoords(
      latitude: firstAddress.coordinates.latitude,
      longitude: firstAddress.coordinates.longitude,
    )));
  };
}
