import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:meta/meta.dart';

class LocationState {
  bool isLoading;
  List<GasStation> stations;
  Location fromLocation;
  int selectedStation;
  ErrorType error;

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