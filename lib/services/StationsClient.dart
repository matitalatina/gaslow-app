import 'dart:convert';

import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/utils/Secrets.dart';
import 'package:http/http.dart';

class StationsClient {
  Future<List<GasStation>> getStationsByCoords({num latitude, num longitude}) async {
    final url = "https://8ed24646q5.execute-api.eu-west-1.amazonaws.com/prod/stations/find/location?lat=$latitude&lng=$longitude";
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