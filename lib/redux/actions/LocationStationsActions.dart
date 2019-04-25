import 'dart:async';
import 'dart:convert';

import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/services/StationsClient.dart';
import 'package:http/http.dart';
import 'package:location/location.dart' as Loc;
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:geocoder/geocoder.dart';

class LocationFetchStationsSuccess {
  final List<GasStation> stations;

  LocationFetchStationsSuccess({this.stations});
}

class LocationFetchStationsStart {}

class UpdateFromLocation {
  final Location fromLocation;

  UpdateFromLocation({@required this.fromLocation});
}

class LocationUpdateToLocation {
  final Location toLocation;

  LocationUpdateToLocation({@required this.toLocation});
}

class LocationSelectStationAction {
  final int stationId;

  LocationSelectStationAction({@required this.stationId});
}

fetchStationsByCurrentLocationAction(Store<AppState> store) async {
  store.dispatch(LocationFetchStationsStart());
  Map<String, double> currentLocation = await new Loc.Location().getLocation();

  store.dispatch(new UpdateFromLocation(
      fromLocation: Location.fromPoint(
    latitude: currentLocation['latitude'],
    longitude: currentLocation['longitude'],
  )));

  store.dispatch(new LocationFetchStationsSuccess(
      stations: await StationsClient().getStationsByCoords(
    latitude: currentLocation['latitude'],
    longitude: currentLocation['longitude'],
  )));
}

fetchStationsByPlaceNameAction(String name) {
  return (Store<AppState> store) async {
    store.dispatch(LocationFetchStationsStart());
    Address firstAddress =
        (await Geocoder.local.findAddressesFromQuery(name)).first;

    store.dispatch(new LocationUpdateToLocation(
        toLocation: Location.fromPoint(
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
