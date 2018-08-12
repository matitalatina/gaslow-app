import 'dart:convert';

import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:location/location.dart';

class FetchStationByLocationSuccess {
  final List<GasStation> stations;

  FetchStationByLocationSuccess({this.stations});
}

class FetchStationByLocationStart {}

// ignore: strong_mode_top_level_function_literal_block
final fetchStationsByLocationAction = (Store<AppState> store) async {
  store.dispatch(FetchStationByLocationStart());
  Map<String, double> currentLocation = await new Location().getLocation;
  final response = await get("https://gaslow.herokuapp.com/stations/find/location?lat=${currentLocation['latitude']}&lng=${currentLocation['longitude']}");
  if (200 <= response.statusCode && response.statusCode <= 299) {
    final stations = (json.decode(response.body)['items'] as List).cast<Map<String, dynamic>>().map((Map g) => new GasStation.fromJson(g)).toList();
    store.dispatch(new FetchStationByLocationSuccess(stations: stations));
  }
};