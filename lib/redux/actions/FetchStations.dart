import 'dart:async';
import 'dart:convert';

import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class FetchStationSuccess {
  final List<GasStation> stations;

  FetchStationSuccess({this.stations});
}

class FetchStationStart {}

fetchStationsByLocationAction(Store<AppState> store) async {
  store.dispatch(FetchStationStart());
  Map<String, double> currentLocation = await new Location().getLocation;

  store.dispatch(new FetchStationSuccess(
      stations: await _getStationsByCoords(
    latitude: currentLocation['latitude'],
    longitude: currentLocation['longitude'],
  )));
}

fetchStationsByPlaceNameAction(String name) {
  return (Store<AppState> store) async {
    store.dispatch(FetchStationStart());
    Address firstAddress =
        (await Geocoder.local.findAddressesFromQuery(name)).first;
    store.dispatch(new FetchStationSuccess(
        stations: await _getStationsByCoords(
      latitude: firstAddress.coordinates.latitude,
      longitude: firstAddress.coordinates.longitude,
    )));
  };
}

Future<List<GasStation>> _getStationsByCoords(
    {num latitude, num longitude}) async {
  final response = await get(
      "https://gaslow.herokuapp.com/stations/find/location?lat=$latitude&lng=$longitude");
  if (200 <= response.statusCode && response.statusCode <= 299) {
    return (json.decode(response.body)['items'] as List)
        .cast<Map<String, dynamic>>()
        .map((Map g) => new GasStation.fromJson(g))
        .toList();
  }
  return [];
}
