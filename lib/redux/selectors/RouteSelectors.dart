import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/utils/StationUtils.dart';
import 'package:collection/collection.dart';

import '../RouteState.dart';

List<GasStation> getRouteStationsSortedByPrice(RouteState state, FuelTypeEnum preferredFuelType) {
  return sortStationsByPrice(state.stations, preferredFuelType);
}

GasStation? getRouteSelectedStation(RouteState state) =>
    state.stations.firstWhereOrNull((s) => s.id == state.selectedStation);
