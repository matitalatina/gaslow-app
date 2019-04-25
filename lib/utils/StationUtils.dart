import 'package:gaslow_app/models/GasStation.dart';

List<GasStation> sortStationsByPrice(List<GasStation> stations) {
  return stations.where((s) => s.prices.isNotEmpty).toList()
    ..sort((s1, s2) => s1.prices
        .firstWhere((p) => p.isSelf && p.fuelType.contains("enz"),
            orElse: () => s1.prices[0])
        .price
        .compareTo(s2.prices
            .firstWhere((p) => p.isSelf && p.fuelType.contains("enz"),
                orElse: () => s2.prices[0])
            .price));
}
