import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

List<GasStation> sortStationsByPrice(List<GasStation> stations, FuelTypeEnum fuelTypeEnum) {
  final sortedStations = stations.where((s) => s.prices.any((p) => p.fuelTypeEnum == fuelTypeEnum)).toList()
    ..sort((s1, s2) => s1.prices
        .firstWhere((p) => p.isSelf && p.fuelTypeEnum == fuelTypeEnum,
            orElse: () => s1.prices[0])
        .price
        .compareTo(s2.prices
            .firstWhere((p) => p.isSelf && p.fuelTypeEnum == fuelTypeEnum,
                orElse: () => s2.prices[0])
            .price));
  sortedStations.forEach((s) => s.prices.sort((p1, p2) {
    final fuelTypeWeight1 = p1.fuelTypeEnum == fuelTypeEnum ? 1 : (p1.fuelTypeEnum.index + 1) * 1000;
    final fuelTypeWeight2 = p2.fuelTypeEnum == fuelTypeEnum ? 1 : (p2.fuelTypeEnum.index + 1) * 1000;
    return (fuelTypeWeight1 + p1.price).compareTo(fuelTypeWeight2 + p2.price);
  }));
  return sortedStations;
}

NumberFormat getNumberFormat() {
  return NumberFormat("##0.000", "it_IT");
}

String getGoogleMapsUrl(GasStation station) {
  return 'https://www.google.com/maps/search/?api=1&query=${station.location.coordinates[1]},${station.location.coordinates[0]}';
}

openMap(GasStation station) async {
  var url = getGoogleMapsUrl(station);
  if (await canLaunch(url)) {
    await launch(url);
  }
}

