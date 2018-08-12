import 'package:gaslow_app/models/GasStation.dart';

class StationsState {
  bool isLoading;
  List<GasStation> stations;

  StationsState({this.isLoading, this.stations});
}