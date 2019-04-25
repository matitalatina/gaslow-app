import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';

import 'MapWidget.dart';
import 'StationsWidget.dart';

class StationMapList extends StatelessWidget {
  final List<GasStation> stations;
  final Location fromLocation;
  final bool isLoading;
  final GasStation selectedStation;
  final ValueChanged<int> onStationTap;

  const StationMapList(
      {Key key,
      @required this.stations,
      this.fromLocation,
      @required this.isLoading,
      this.selectedStation,
      @required this.onStationTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgets = [
      Flexible(
          flex: 1,
          child: MapWidget(
            stations: stations,
            isLoading: isLoading,
            fromLocation: fromLocation,
            selectedStation: selectedStation,
            onStationTap: onStationTap,
          )),
      Flexible(
          flex: 2,
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
