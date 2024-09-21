import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/models/GasPrice.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:intl/intl.dart';

List<GasStation> sortStationsByPrice(
    List<GasStation> stations, FuelTypeEnum fuelTypeEnum) {
  final sortedStations = List<GasStation>.from(stations)
      .where((s) => s.prices.any((p) => p.fuelTypeEnum == fuelTypeEnum))
      .toList();

  sortedStations.forEach((s) => s.prices.sort((p1, p2) {
        final priceComparison = (_getPriceWeight(p1, fuelTypeEnum))
            .compareTo(_getPriceWeight(p2, fuelTypeEnum));
        if (priceComparison != 0) {
          return priceComparison;
        }
        return p2.updatedAt.millisecondsSinceEpoch
            .compareTo(p1.updatedAt.millisecondsSinceEpoch);
      }));

  return sortedStations
    ..sort((s1, s2) => s1.prices
        .firstWhere((p) => p.fuelTypeEnum == fuelTypeEnum,
            orElse: () => s1.prices[0])
        .price
        .compareTo(s2.prices
            .firstWhere((p) => p.fuelTypeEnum == fuelTypeEnum,
                orElse: () => s2.prices[0])
            .price));
}

_getPriceWeight(GasPrice price, FuelTypeEnum selectedFuelType) {
  final fuelTypeWeight = price.fuelTypeEnum == selectedFuelType
      ? 1
      : (price.fuelTypeEnum.index + 1) * 1000;
  return fuelTypeWeight + price.price;
}

NumberFormat getNumberFormat() {
  return NumberFormat("##0.000", "it_IT");
}

Uri getGoogleMapsUrl(GasStation station) {
  return Uri.parse('https://www.google.com/maps/search/?api=1&query=${station.location.coordinates[1]},${station.location.coordinates[0]}');
}
