import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:meta/meta.dart';

class RouteState {
  bool isLoading;
  List<GasStation> stations;
  Location fromLocation;
  Location toLocation;
  int selectedStation;

  RouteState({
    @required this.isLoading,
    @required this.stations,
    @required this.fromLocation,
    @required this.toLocation,
    @required this.selectedStation,
  });
}

RouteState getDefaultRouteState() {
  return RouteState(
      isLoading: false,
      stations: [],
      fromLocation: null,
      toLocation: null,
      selectedStation: null,
  );
}
