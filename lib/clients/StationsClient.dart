import 'dart:convert';

import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/utils/Secrets.dart';
import 'package:http/http.dart';

class StationsClient {
  //static const BACKEND_URL = "https://8ed24646q5.execute-api.eu-west-1.amazonaws.com/prod";
  static const BACKEND_URL = "https://gaslow-api.mattianatali.com";

  Future<List<GasStation>> getStationsByCoords(
      {required num latitude, required num longitude}) async {
    final url = Uri.parse(
        "$BACKEND_URL/stations/find/location?lat=$latitude&lng=$longitude");
    return getStations(url);
  }

  Future<List<GasStation>> getStationsByRoute(
      {required num fromLatitude,
      required num fromLongitude,
      required num toLatitude,
      required num toLongitude}) async {
    final url = Uri.parse(
        "$BACKEND_URL/stations/find/route?from=$fromLatitude,$fromLongitude&to=$toLatitude,$toLongitude");
    return getStations(url);
  }

  Future<List<GasStation>> getByIds(Set<int> ids) async {
    final url = Uri.parse(
        "$BACKEND_URL/stations/find?ids=${ids.join(",")}");
    return getStations(url);
  }

  Future<List<GasStation>> getStations(Uri url) async {
    final headers = {
      'X-API-KEY': await Secrets.getServerlessApiKey(),
    };
    final response = await get(url, headers: headers);
    if (200 <= response.statusCode && response.statusCode <= 299) {
      return (json.decode(response.body)['items'] as List)
          .cast<Map<String, dynamic>>()
          .map((Map g) => new GasStation.fromJson(g))
          .toList();
    }
    return [];
  }
}
