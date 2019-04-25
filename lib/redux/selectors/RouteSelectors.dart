import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/utils/StationUtils.dart';

import '../RouteState.dart';

List<GasStation> getRouteStationsSortedByPrice(RouteState state) {
  return sortStationsByPrice(state.stations);
}

GasStation getRouteSelectedStation(RouteState state) =>
    state.stations.firstWhere((s) => s.id == state.selectedStation, orElse: () => null);
