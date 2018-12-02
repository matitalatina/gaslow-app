import 'package:gaslow_app/models/GasStation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkers {
  static MarkerOptions station(GasStation station, BitmapDescriptor icon, double alpha) {
    var prices = station.prices
        .where((p) => p.isSelf)
        .map((p) => "${p.fuelType.substring(0, 1)}: € ${p.price.toString()}");
    var text = prices.isNotEmpty ? prices.reduce((a, b) => a + "; " + b): "";
    var markerOptions = MarkerOptions(
        position: LatLng(station.location.latitude, station.location.longitude),
        icon: icon,
        alpha: alpha,
        infoWindowText: InfoWindowText(
          station.brand,
          text,
        ));
    return markerOptions;
  }
}