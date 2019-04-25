import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/map/MapMarkers.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final List<GasStation> stations;
  final Location fromLocation;
  final Location toLocation;
  final bool isLoading;
  final GasStation selectedStation;
  final IntCallback onStationTap;

  const MapWidget({
    Key key,
    @required this.stations,
    @required this.isLoading,
    this.selectedStation,
    this.fromLocation,
    this.toLocation,
    @required this.onStationTap,
  }) : super(key: key);

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
    return _showMap();
  }

  GoogleMap _showMap() {
    if (mapController != null) {
      _prepareMap(mapController);
    }
    return GoogleMap(onMapCreated: _onMapCreated);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    controller.clearMarkers().then((_) => widget.stations
        .asMap()
        .map(_createMapEntry)
        .forEach((_, m) => controller.addMarker(m)));

    if (widget.fromLocation != null) {
      controller.addMarker(_createPositionMarker(widget.fromLocation, "Posizione corrente"));
    }

    if (widget.toLocation != null) {
      controller.addMarker(_createPositionMarker(widget.toLocation, "Destinazione"));
    }

    controller.moveCamera(CameraUpdate.zoomTo(13));
    _prepareMap(controller);
  }

  MapEntry<int, MarkerOptions> _createMapEntry(index, station) {
    var alpha = (1 - index / widget.stations.length);
    var greenHue = 130;
    var scaleFactor = 1.4;
    var icon = BitmapDescriptor.defaultMarkerWithHue(max(
        greenHue - (index / widget.stations.length * greenHue) * scaleFactor,
        0));
    MarkerOptions markerOptions = MapMarkers.station(station, icon, alpha);
    return MapEntry(index, markerOptions);
  }

  MarkerOptions _createPositionMarker(Location location, String title) {
    return MarkerOptions(
      position:
      LatLng(location.latitude, location.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindowText: InfoWindowText(title, null),
    );
  }

  void _prepareMap(GoogleMapController controller) {
    controller.onMarkerTapped.add(_onMarkerTapped);

    var cameraUpdate;
    if (widget.selectedStation != null) {
      cameraUpdate = CameraUpdate.newLatLng(LatLng(
          widget.selectedStation.location.latitude,
          widget.selectedStation.location.longitude));
    } else if (widget.fromLocation != null) {
      cameraUpdate = CameraUpdate.newLatLngZoom(
          LatLng(widget.fromLocation.latitude, widget.fromLocation.longitude),
          11);
    } else if (widget.stations.isNotEmpty) {
      cameraUpdate = CameraUpdate.newLatLngZoom(
          LatLng(widget.stations[0].location.latitude,
              widget.stations[0].location.longitude),
          11);
    }
    controller.moveCamera(cameraUpdate);
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
