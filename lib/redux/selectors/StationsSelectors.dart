import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/redux/StationsState.dart';

List<GasStation> getStationsSortedByPrice(StationsState state) {
  var stations = List<GasStation>.from(state.stations).where((s) => s.prices.isNotEmpty).toList();
  return stations..sort((s1, s2) => s1.prices
      .firstWhere((p) => p.isSelf && p.fuelType.contains("enz"), orElse: () => s1.prices[0])
      .price
      .compareTo(s2.prices
      .firstWhere((p) => p.isSelf && p.fuelType.contains("enz"), orElse: () => s2.prices[0])
      .price));
}

GasStation getSelectedStation(StationsState state) =>
    state.stations.firstWhere((s) => s.id == state.selectedStation, orElse: () => null);
