import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/LocationState.dart';
import 'package:gaslow_app/utils/StationUtils.dart';

List<GasStation> getLocationStationsSortedByPrice(LocationState state, FuelTypeEnum preferredFuelType) {
  return sortStationsByPrice(state.stations, preferredFuelType);
}

GasStation getLocationSelectedStation(LocationState state) =>
    state.stations.firstWhere((s) => s.id == state.selectedStation, orElse: () => null);
