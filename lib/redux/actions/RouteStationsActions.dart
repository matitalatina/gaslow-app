import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/services/StationsClient.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart' as Loc;
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class RouteFetchStationsSuccess {
  final List<GasStation> stations;

  RouteFetchStationsSuccess({this.stations});
}

class RouteFetchStationsStart {}

class RouteSelectStationAction {
  final int stationId;

  RouteSelectStationAction({@required this.stationId});
}

class RouteUpdateFromLocation {
  final Location fromLocation;

  RouteUpdateFromLocation({@required this.fromLocation});
}

class RouteUpdateToLocation {
  final Location toLocation;

  RouteUpdateToLocation({@required this.toLocation});
}

fetchStationsByDestinationNameAction(String name) {
  return (Store<AppState> store) async {
    store.dispatch(RouteFetchStationsStart());

    Map<String, double> currentLocation =
        await new Loc.Location().getLocation();

    store.dispatch(new RouteUpdateFromLocation(
        fromLocation: Location.fromPoint(
      latitude: currentLocation['latitude'],
      longitude: currentLocation['longitude'],
    )));

    Address firstAddress =
        (await Geocoder.local.findAddressesFromQuery(name)).first;

    store.dispatch(new RouteUpdateToLocation(
        toLocation: Location.fromPoint(
      latitude: firstAddress.coordinates.latitude,
      longitude: firstAddress.coordinates.longitude,
    )));

    store.dispatch(new RouteFetchStationsSuccess(
        stations: await StationsClient().getStationsByRoute(
      fromLatitude: currentLocation['latitude'],
      fromLongitude: currentLocation['longitude'],
      toLatitude: firstAddress.coordinates.latitude,
      toLongitude: firstAddress.coordinates.longitude,
    )));
  };
}
