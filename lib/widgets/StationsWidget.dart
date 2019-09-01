import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:gaslow_app/utils/StationUtils.dart';
import 'package:gaslow_app/widgets/StationTile.dart';

class StationsWidget extends StatefulWidget {
  final List<GasStation> stations;
  final bool isLoading;
  final Location fromLocation;
  final GasStation selectedStation;

  final IntCallback onStationTap;
  final IntCallback onStationShare;

  StationsWidget({
    @required this.stations,
    @required this.isLoading,
    @required this.onStationTap,
    @required this.selectedStation,
    this.fromLocation,
    this.onStationShare,
  });

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
                onMapTap: () => openMap(station),
                fromLocation: widget.fromLocation,
                onShareTap: widget.onStationShare,
              ));
            });
  }
}
