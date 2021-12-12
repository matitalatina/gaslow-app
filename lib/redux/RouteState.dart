import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/MyLocation.dart';

class RouteState {
  final bool isLoading;
  final List<GasStation> stations;
  final MyLocation? fromLocation;
  final MyLocation? toLocation;
  final int? selectedStation;
  final ErrorType error;

  RouteState({
    required this.isLoading,
    required this.stations,
    required this.fromLocation,
    required this.toLocation,
    required this.selectedStation,
    required this.error,
  });
}

RouteState getDefaultRouteState() {
  return RouteState(
      isLoading: false,
      stations: [],
      fromLocation: null,
      toLocation: null,
      selectedStation: null,
      error: ErrorType.NONE,
  );
}
