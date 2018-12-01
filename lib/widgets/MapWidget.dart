import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final List<GasStation> stations;
  final Location fromLocation;
  final bool isLoading;
  final GasStation selectedStation;
  final IntCallback onStationTap;

  const MapWidget(
      {Key key,
      @required this.stations,
      @required this.isLoading,
      this.selectedStation,
      this.fromLocation,
      @required this.onStationTap})
      : super(key: key);

  @override
  State createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      if (mapController != null) {
        mapController.dispose();
        mapController = null;
      }
      return Center(child: CircularProgressIndicator());
    }
    return showMap();
  }

  GoogleMap showMap() {
    if (mapController != null) {
      prepareMap(mapController);
    }
    return GoogleMap(onMapCreated: _onMapCreated);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    controller.clearMarkers().then((_) => widget.stations
        .asMap()
        .map((index, s) => MapEntry(
            index,
            MarkerOptions(
                position: LatLng(s.location.latitude, s.location.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    max(130 - (index / widget.stations.length * 130) * 1.4, 0)),
                alpha: (1 - index / widget.stations.length))))
        .forEach((_, m) => controller.addMarker(m)));
    prepareMap(controller);
  }

  void prepareMap(GoogleMapController controller) {
    controller.onMarkerTapped.add(_onMarkerTapped);
    if (widget.selectedStation != null) {
      controller.moveCamera(CameraUpdate.newLatLngZoom(LatLng(
          widget.selectedStation.location.latitude,
          widget.selectedStation.location.longitude),
        13));
    } else if (widget.fromLocation != null) {
      controller.moveCamera(CameraUpdate.newLatLngZoom(
          LatLng(widget.fromLocation.latitude, widget.fromLocation.longitude),
          13));
    } else if (widget.stations.isNotEmpty) {
      controller.moveCamera(CameraUpdate.newLatLngZoom(
          LatLng(widget.stations[0].location.latitude, widget.stations[0].location.longitude),
          13));
    }
  }

  void _onMarkerTapped(Marker marker) {
    var stationTapped = widget.stations.firstWhere(
        (s) =>
            s.location.latitude == marker.options.position.latitude &&
            s.location.longitude == marker.options.position.longitude,
        orElse: () => null);

    if (stationTapped != null) {
      widget.onStationTap(stationTapped.id);
    }
  }
}
