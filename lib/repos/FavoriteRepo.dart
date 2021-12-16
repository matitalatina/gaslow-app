import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String _FAVORITE_STATION_IDS = "FAVORITE.STATION_IDS";

class FavoriteRepo {
  Future<Set<int>> getStationIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Set<int>.from(jsonDecode(prefs.getString(_FAVORITE_STATION_IDS) ?? "[]"));
  }

  Future<void> setStationIds(Set<int> ids) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_FAVORITE_STATION_IDS, jsonEncode(ids.toList()));
  }
}