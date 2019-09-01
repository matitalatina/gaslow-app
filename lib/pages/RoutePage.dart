import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/RouteState.dart';
import 'package:gaslow_app/redux/actions/CoreActions.dart';
import 'package:gaslow_app/redux/actions/RouteStationsActions.dart';
import 'package:gaslow_app/redux/selectors/RouteSelectors.dart';
import 'package:gaslow_app/services/ShareService.dart';
import 'package:gaslow_app/widgets/call_to_action/NoConnection.dart';
import 'package:gaslow_app/widgets/call_to_action/NoLocationPermission.dart';
import 'package:gaslow_app/widgets/SearchField.dart';
import 'package:gaslow_app/widgets/StationMapList.dart';
import 'package:gaslow_app/widgets/StationTile.dart';

class RoutePage extends StatefulWidget {
  RoutePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RoutePageState createState() => new _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stationList = new StoreConnector<AppState, RoutePageVm>(
      converter: (store) => RoutePageVm(
        state: store.state.routeState,
        preferredFuelType: store.state.settingsState.preferredFuelType,
        onStationTap: (stationId) =>
            store.dispatch(RouteSelectStationAction(stationId: stationId)),
        hasLocationPermission: store.state.backendState.hasLocationPermission,
        onRequestLocationPermission: () =>
            store.dispatch(requestLocationPermission),
        onFindRoute: () => store.dispatch(
            fetchStationsByDestinationNameAction(searchController.text)),
        error: store.state.routeState.error,
      ),
      builder: (context, homeVm) {
        var stationsState = homeVm.state;
        var stations = getRouteStationsSortedByPrice(
            stationsState, homeVm.preferredFuelType);
        var selectedStation = getRouteSelectedStation(stationsState);

        if (!homeVm.hasLocationPermission) {
          return NoLocationPermission(
              onRequestPermission: homeVm.onRequestLocationPermission);
        }

        if (homeVm.error == ErrorType.CONNECTION) {
          return NoConnection(
              onRetry: homeVm.onFindRoute);
        }

        return StationMapList(
          stations: stations,
          isLoading: stationsState.isLoading,
          fromLocation: stationsState.fromLocation,
          toLocation: stationsState.toLocation,
          selectedStation: selectedStation,
          onStationTap: homeVm.onStationTap,
          onShareTap: (stationId) => ShareService.shareStation(stations.firstWhere((s) => s.id == stationId)),
        );
      },
    );

    final searchField =
        new StoreConnector<AppState, ValueChanged<String>>(converter: (store) {
      return store.state.backendState.hasLocationPermission
          ? (text) => store.dispatch(fetchStationsByDestinationNameAction(text))
          : null;
    }, builder: (context, searchStationCallback) {
      return SearchField(
        onSearch: searchStationCallback,
        textController: searchController,
        placeholder: "Cerca la destinazione...",
        enabled: searchStationCallback != null,
      );
    });

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        //title: new GaslowTitle(title: widget.title),
        //actions: <Widget>[backendRefreshButton],
        title: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            height: 48.0,
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              child: searchField,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: stationList,
      resizeToAvoidBottomInset: false,
    );
  }
}

class RoutePageVm {
  final RouteState state;
  final FuelTypeEnum preferredFuelType;
  final IntCallback onStationTap;
  final bool hasLocationPermission;
  final VoidCallback onRequestLocationPermission;
  final VoidCallback onFindRoute;
  final ErrorType error;

  RoutePageVm({
    @required this.state,
    @required this.onStationTap,
    @required this.preferredFuelType,
    @required this.hasLocationPermission,
    @required this.onRequestLocationPermission,
    @required this.onFindRoute,
    @required this.error,
  });
}
