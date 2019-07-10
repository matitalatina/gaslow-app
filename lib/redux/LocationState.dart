import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:meta/meta.dart';

class LocationState {
  final bool isLoading;
  final List<GasStation> stations;
  final Location fromLocation;
  final int selectedStation;
  final ErrorType error;

  LocationState({
    @required this.isLoading,
    @required this.stations,
    @required this.fromLocation,
    @required this.selectedStation,
    @required this.error,
  });
}

LocationState getDefaultStationsState(){
  return LocationState(
      isLoading: false,
      stations: [],
      fromLocation: null,
      selectedStation: null,
      error: ErrorType.NONE,
  );
}