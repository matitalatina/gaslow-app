import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gaslow_app/map/MapMarkers.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/MyLocation.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final List<GasStation> stations;
  final MyLocation fromLocation;
  final MyLocation toLocation;
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

class _MapWidgetState extends State<MapWidget> with WidgetsBindingObserver {
  static const DEFAULT_MAP_ZOOM = 11.0;
  static const SELECTED_MAP_ZOOM = 14.0;

  Completer<GoogleMapController> mapControllerCompleter = Completer();
  GoogleMap cachedMap;

  List<GasStation> stations;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return _showMap();
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // https://github.com/flutter/flutter/issues/40284#issuecomment-866377474
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initMapStyle();
    }
  }

  Future<void> _initMapStyle() async {
    var mapController = await mapControllerCompleter.future;
    mapController.setMapStyle("[]");
  }

  bool _stationsAreTheSame() {
    final oldStationsIds = (stations ?? []).map((s) => s.id).join(",");
    final newStationsIds = (widget.stations ?? []).map((s) => s.id).join(",");
    return oldStationsIds == newStationsIds;
  }

  GoogleMap _showMap() {
    mapControllerCompleter.future.then((value) => _prepareMap(value));
    if (cachedMap != null && _stationsAreTheSame()) {
      return cachedMap;
    }
    cachedMap = GoogleMap(
      initialCameraPosition: CameraPosition(
          target: _getFirstLatLng(),
          zoom: DEFAULT_MAP_ZOOM),
      onMapCreated: _onMapCreated,
      markers: _getMarkers(),
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      myLocationButtonEnabled: false,
    );
    stations = widget.stations;
    return cachedMap;
  }

  LatLng _getFirstLatLng() {
    final initialPosition = [
      widget.selectedStation?.location,
      widget.toLocation,
      widget.fromLocation,
      MyLocation(type: "Point", coordinates: [9.669960, 45.694889]) // Bergamo
    ].firstWhere((l) => l != null);
    return LatLng(initialPosition.latitude, initialPosition.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapControllerCompleter.complete(controller);
    controller.moveCamera(CameraUpdate.zoomTo(13));
    _prepareMap(controller);
  }

  Set<Marker> _getMarkers() {
    Set<Marker> setMarkers = Set<Marker>();
    setMarkers.addAll(widget.stations
        .asMap()
        .map(_createMapEntry)
        .values);
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
    Marker markerOptions =
    MapMarkers.station(station, icon, alpha, _onStationTapped);
    return MapEntry(index, markerOptions);
  }

  Marker _createPositionMarker(MyLocation location, String title) {
    return Marker(
      markerId: MarkerId("position-${location.latitude}-${location.longitude}"),
      position: LatLng(location.latitude, location.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: title),
    );
  }

  void _prepareMap(GoogleMapController controller) {
    final latLng = _getFirstLatLng();
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        latLng,
        widget.selectedStation != null ? SELECTED_MAP_ZOOM : DEFAULT_MAP_ZOOM));
  }

  void _onStationTapped(int stationId) {
    widget.onStationTap(stationId);
  }
}
