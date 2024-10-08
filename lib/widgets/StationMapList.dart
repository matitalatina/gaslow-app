import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/MyLocation.dart';
import 'package:gaslow_app/widgets/LoaderVerbose.dart';
import 'package:gaslow_app/widgets/MapWidget.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:gaslow_app/widgets/StationsList.dart';


class StationMapList extends StatelessWidget {
  final List<GasStation> stations;
  final MyLocation? fromLocation;
  final MyLocation? toLocation;
  final bool isLoading;
  final GasStation? selectedStation;
  final ValueChanged<int> onStationTap;
  final ValueChanged<int>? onShareTap;
  final FavoriteCallback onFavoriteChange;
  final Set<int> favoriteStationIds;

  const StationMapList({
    Key? key,
    required this.stations,
    this.fromLocation,
    this.toLocation,
    required this.isLoading,
    this.selectedStation,
    required this.onStationTap,
    this.onShareTap,
    required this.onFavoriteChange,
    required this.favoriteStationIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
          child: LoaderVerbose(),
      );
    }

    if (fromLocation == null && stations.length == 0) {
      return SizedBox.shrink();
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
          child: StationsList(
            onStationTap: onStationTap,
            stations: stations,
            isLoading: isLoading,
            fromLocation: fromLocation,
            selectedStation: selectedStation,
            onStationShare: onShareTap,
            favoriteStationIds: favoriteStationIds,
            onFavoriteChange: onFavoriteChange,
          ))
    ];
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Column(children: widgets)
        : Row(children: widgets);
  }
}
