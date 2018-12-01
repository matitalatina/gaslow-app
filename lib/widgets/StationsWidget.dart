import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gaslow_app/widgets/StationTile.dart';

class StationsWidget extends StatefulWidget {
  final List<GasStation> stations;
  final bool isLoading;
  final Location fromLocation;
  final GasStation selectedStation;

  final IntCallback onStationTap;

  StationsWidget({
    @required this.stations,
    @required this.isLoading,
    @required this.onStationTap,
    @required this.selectedStation,
    this.fromLocation,
  });

  openMap(GasStation station) async {
    var url =
        'https://www.google.com/maps/search/?api=1&query=${station.location.coordinates[1]},${station.location.coordinates[0]}';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  State<StatefulWidget> createState() => _StationWidgetState();
}

class _StationWidgetState extends State<StationsWidget> {
//  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
//    if (widget.selectedStation != null) {
//      _controller.animateTo(
//          widget.stations.indexOf(widget.selectedStation) as double,
//          curve: Curves.easeOut,
//          duration: const Duration(milliseconds: 300));
//    }
    return widget.isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
        shrinkWrap: false,
        itemCount: widget.stations.length,
        itemBuilder: (context, index) {
          final station = widget.stations[index];
          return GestureDetector(
              child: StationTile(
                onStationTap: widget.onStationTap,
                station: station,
                onMapTap: () => widget.openMap(station),
                fromLocation: widget.fromLocation,
              ));
        });
  }
}