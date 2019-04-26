import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/utils/StationUtils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkers {
  static Marker station(GasStation station, BitmapDescriptor icon, double alpha, ValueChanged<int> onStationTapped) {
    var prices = station.prices
        .where((p) => p.isSelf)
        .map((p) => "${p.fuelType.substring(0, 1)}: € ${getNumberFormat().format(p.price)}");
    var text = prices.isNotEmpty ? prices.reduce((a, b) => a + "; " + b): "";
    var markerOptions = Marker(
        markerId: MarkerId("station-${station.id}"),
        position: LatLng(station.location.latitude, station.location.longitude),
        icon: icon,
        alpha: alpha,
        onTap: () => onStationTapped(station.id),
        infoWindow: InfoWindow(
          title: station.brand,
          snippet: text,
        ));
    return markerOptions;
  }
}