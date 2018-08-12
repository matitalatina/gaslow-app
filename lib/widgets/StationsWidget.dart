import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gaslow_app/widgets/StationTile.dart';

class StationsWidget extends StatelessWidget {
  final List<GasStation> stations;
  final bool isLoading;

  StationsWidget({
    @required this.stations,
    @required this.isLoading,
  });

  openMap(GasStation station) async {
    var url = 'https://www.google.com/maps/search/?api=1&query=${station
        .location.coordinates[1]},${station.location.coordinates[0]}';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    stations.sort((s1, s2) =>
        s1.prices
            .firstWhere((p) => p.isSelf && p.fuelType.contains("enz"),
            orElse: () => s1.prices[0])
            .price
            .compareTo(s2.prices
            .firstWhere((p) => p.isSelf && p.fuelType.contains("enz"),
            orElse: () => s2.prices[0])
            .price));
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder
      (
        shrinkWrap: false,
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return StationTile(
              station: station, onTap: () => openMap(station));
        }
    );
  }
}
