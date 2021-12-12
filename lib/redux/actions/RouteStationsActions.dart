import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/MyLocation.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/services/StationsClient.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as Loc;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class RouteFetchStationsSuccess {
  final List<GasStation> stations;

  RouteFetchStationsSuccess({required this.stations});
}

class RouteFetchStationsError {
  final ErrorType error;

  RouteFetchStationsError({required this.error});
}

class RouteFetchStationsStart {}

class RouteSelectStationAction {
  final int stationId;

  RouteSelectStationAction({required this.stationId});
}

class RouteUpdateFromLocation {
  final MyLocation fromLocation;

  RouteUpdateFromLocation({required this.fromLocation});
}

class RouteUpdateToLocation {
  final MyLocation toLocation;

  RouteUpdateToLocation({required this.toLocation});
}

ThunkAction<AppState> fetchStationsByDestinationNameAction(String name) {
  return (Store<AppState> store) async {
    final analytics = getIt<FirebaseAnalytics>();
    await analytics.logSearch(
      searchTerm: 'Route',
      destination: name,
    );
    store.dispatch(RouteFetchStationsStart());

    try {
      Loc.LocationData currentLocation = await new Loc.Location().getLocation();
      if (currentLocation.latitude == null || currentLocation.longitude == null) {
        return;
      }
      store.dispatch(new RouteUpdateFromLocation(
          fromLocation: MyLocation.fromPoint(
        latitude: currentLocation.latitude!,
        longitude: currentLocation.longitude!,
      )));

      var firstAddress =
          (await locationFromAddress(name)).first;

      store.dispatch(new RouteUpdateToLocation(
          toLocation: MyLocation.fromPoint(
        latitude: firstAddress.latitude,
        longitude: firstAddress.longitude,
      )));
      store.dispatch(new RouteFetchStationsSuccess(
          stations: await StationsClient().getStationsByRoute(
        fromLatitude: currentLocation.latitude!,
        fromLongitude: currentLocation.longitude!,
        toLatitude: firstAddress.latitude,
        toLongitude: firstAddress.longitude,
      )));
    } catch (e) {
      store.dispatch(new RouteFetchStationsError(error: ErrorType.CONNECTION));
    }
  };
}
