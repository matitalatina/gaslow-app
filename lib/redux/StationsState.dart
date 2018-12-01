import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:meta/meta.dart';

class StationsState {
  bool isLoading;
  List<GasStation> stations;
  Location fromLocation;
  int selectedStation;

  StationsState({
    @required this.isLoading,
    @required this.stations,
    @required this.fromLocation,
    @required this.selectedStation,
  });
}
