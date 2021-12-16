import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/FavoriteState.dart';
import 'package:gaslow_app/utils/StationUtils.dart';
import 'package:collection/collection.dart';

List<GasStation> getFavoriteStationsSortedByPrice(FavoriteState state, FuelTypeEnum preferredFuelType) {
  return sortStationsByPrice(state.stations.toList(), preferredFuelType);
}

GasStation? getFavoriteSelectedStation(FavoriteState state) =>
    state.stations.firstWhereOrNull((s) => s.id == state.selectedStation);