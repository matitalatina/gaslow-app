import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:gaslow_app/widgets/NoLocationPermission.dart';

import 'MapWidget.dart';
import 'StationsWidget.dart';

class StationMapList extends StatelessWidget {
  final List<GasStation> stations;
  final Location fromLocation;
  final Location toLocation;
  final bool isLoading;
  final GasStation selectedStation;
  final ValueChanged<int> onStationTap;
  final bool hasLocationPermission;
  final VoidCallback onRequestPermission;

  const StationMapList({
    Key key,
    @required this.stations,
    this.fromLocation,
    this.toLocation,
    @required this.isLoading,
    this.selectedStation,
    @required this.onStationTap,
    this.hasLocationPermission = true,
    this.onRequestPermission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (!hasLocationPermission) {
      return NoLocationPermission(onRequestPermission: onRequestPermission);
    }

    var widgets = [
      Flexible(
          flex: 1,
          child: MapWidget(
            stations: stations,
            isLoading: isLoading,
            fromLocation: fromLocation,
            toLocation: toLocation,
            selectedStation: selectedStation,
            onStationTap: onStationTap,
          )),
      Flexible(
          flex: 1,
          child: StationsWidget(
            onStationTap: onStationTap,
            stations: stations,
            isLoading: isLoading,
            fromLocation: fromLocation,
            selectedStation: selectedStation,
          ))
    ];
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Column(children: widgets)
        : Row(children: widgets);
  }
}