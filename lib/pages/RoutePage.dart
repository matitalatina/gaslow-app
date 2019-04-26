import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/RouteState.dart';
import 'package:gaslow_app/redux/LocationState.dart';
import 'package:gaslow_app/redux/actions/LocationStationsActions.dart';
import 'package:gaslow_app/redux/actions/RouteStationsActions.dart';
import 'package:gaslow_app/redux/selectors/LocationSelectors.dart';
import 'package:gaslow_app/redux/selectors/RouteSelectors.dart';
import 'package:gaslow_app/widgets/GaslowTitle.dart';
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
        onStationTap: (stationId) =>
            store.dispatch(RouteSelectStationAction(stationId: stationId)),
      ),
      builder: (context, homeVm) {
        var stationsState = homeVm.state;
        var stations = getRouteStationsSortedByPrice(stationsState);
        var selectedStation = getRouteSelectedStation(stationsState);
        return StationMapList(
          stations: stations,
          isLoading: stationsState.isLoading,
          fromLocation: stationsState.fromLocation,
          toLocation: stationsState.toLocation,
          selectedStation: selectedStation,
          onStationTap: homeVm.onStationTap,
        );
      },
    );

    final searchField =
    new StoreConnector<AppState, ValueChanged<String>>(converter: (store) {
      return (text) =>
          store.dispatch(fetchStationsByDestinationNameAction(text)(store));
    }, builder: (context, searchStationCallback) {
      return SearchField(
        onSearch: searchStationCallback,
        textController: searchController,
        placeholder: "Cerca la destinazione...",
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
  final IntCallback onStationTap;

  RoutePageVm({@required this.state, @required this.onStationTap});
}