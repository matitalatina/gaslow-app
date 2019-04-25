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
  static const DEFAULT_MAP_ZOOM = 11.0;

  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return _showMap();
  }

  GoogleMap _showMap() {
    if (mapController != null) {
      _prepareMap(mapController);
    }
    return GoogleMap(
        initialCameraPosition: _getFirstCameraPosition(),
        onMapCreated: _onMapCreated,
        markers: _getMarkers(),
    );
  }

  CameraPosition _getFirstCameraPosition() {
    final initialPosition = [
      widget.fromLocation,
      widget.toLocation,
      Location(type: "Point", coordinates: [9.669960, 45.694889]) // Bergamo
    ].firstWhere((l) => l != null);
    return CameraPosition(target: LatLng(initialPosition.latitude, initialPosition.longitude), zoom: DEFAULT_MAP_ZOOM);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    controller.moveCamera(CameraUpdate.zoomTo(13));
    _prepareMap(controller);
  }

  Set<Marker> _getMarkers() {
    Set<Marker> setMarkers = Set<Marker>();
    setMarkers.addAll(widget.stations.asMap().map(_createMapEntry).values);
    if (widget.fromLocation != null) {
      setMarkers.add(
          _createPositionMarker(widget.fromLocation, "Posizione corrente"));
    }
    if (widget.toLocation != null) {
      setMarkers.add(_createPositionMarker(widget.toLocation, "Destinazione"));
    }
    return setMarkers;
  }

  MapEntry<int, Marker> _createMapEntry(index, station) {
    var alpha = (1 - index / widget.stations.length);
    var greenHue = 130;
    var scaleFactor = 1.4;
    var icon = BitmapDescriptor.defaultMarkerWithHue(max(
        greenHue - (index / widget.stations.length * greenHue) * scaleFactor,
        0));
    Marker markerOptions = MapMarkers.station(station, icon, alpha, _onStationTapped);
    return MapEntry(index, markerOptions);
  }

  Marker _createPositionMarker(Location location, String title) {
    return Marker(
      markerId: MarkerId("position-${location.latitude}-${location.longitude}"),
      position:
      LatLng(location.latitude, location.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: title),
    );
  }

  void _prepareMap(GoogleMapController controller) {
    var cameraUpdate;
    if (widget.selectedStation != null) {
      cameraUpdate = CameraUpdate.newLatLng(LatLng(
          widget.selectedStation.location.latitude,
          widget.selectedStation.location.longitude));
    } else if (widget.fromLocation != null) {
      cameraUpdate = CameraUpdate.newLatLngZoom(
          LatLng(widget.fromLocation.latitude, widget.fromLocation.longitude),
          DEFAULT_MAP_ZOOM);
    } else if (widget.stations.isNotEmpty) {
      cameraUpdate = CameraUpdate.newLatLngZoom(
          LatLng(widget.stations[0].location.latitude,
              widget.stations[0].location.longitude),
          DEFAULT_MAP_ZOOM);
    }
    controller.moveCamera(cameraUpdate);
  }

  void _onStationTapped(int stationId) {
      widget.onStationTap(stationId);
  }
}
