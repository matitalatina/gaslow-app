import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:intl/intl.dart';

List<GasStation> sortStationsByPrice(List<GasStation> stations, FuelTypeEnum fuelTypeEnum) {
  return stations.where((s) => s.prices.any((p) => p.fuelTypeEnum == fuelTypeEnum)).toList()
    ..sort((s1, s2) => s1.prices
        .firstWhere((p) => p.isSelf && p.fuelTypeEnum == fuelTypeEnum,
            orElse: () => s1.prices[0])
        .price
        .compareTo(s2.prices
            .firstWhere((p) => p.isSelf && p.fuelTypeEnum == fuelTypeEnum,
                orElse: () => s2.prices[0])
            .price));
}

NumberFormat getNumberFormat() {
  return NumberFormat("##0.000", "it_IT");
}