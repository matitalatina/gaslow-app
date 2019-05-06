import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/LocationState.dart';
import 'package:gaslow_app/redux/actions/LocationStationsActions.dart';
import 'package:gaslow_app/redux/selectors/LocationSelectors.dart';
import 'package:gaslow_app/widgets/GaslowTitle.dart';
import 'package:gaslow_app/widgets/SearchField.dart';
import 'package:gaslow_app/widgets/StationMapList.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:gaslow_app/redux/actions/CoreActions.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LocationPageState createState() => new _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stationList = new StoreConnector<AppState, LocationPageVm>(
      converter: (store) => LocationPageVm(
          state: store.state.stationsState,
          onStationTap: (stationId) =>
              store.dispatch(LocationSelectStationAction(stationId: stationId)),
          hasLocationPermission: store.state.backendState.hasLocationPermission,
          onRequestLocationPermission: () =>
              store.dispatch(checkLocationPermissionAndFetchStations)),
      builder: (context, homeVm) {
        var stationsState = homeVm.state;
        var stations = getLocationStationsSortedByPrice(stationsState);
        var selectedStation = getLocationSelectedStation(stationsState);
        return StationMapList(
          stations: stations,
          isLoading: stationsState.isLoading,
          fromLocation: stationsState.fromLocation,
          selectedStation: selectedStation,
          onStationTap: homeVm.onStationTap,
          onRequestPermission: homeVm.onRequestLocationPermission,
          hasLocationPermission: homeVm.hasLocationPermission,
        );
      },
    );

    final floatingButton =
        new StoreConnector<AppState, VoidCallback>(converter: (store) {
      return store.state.backendState.hasLocationPermission
          ? () => store.dispatch(fetchStationsByCurrentLocationAction)
          : null;
    }, builder: (context, updateStation) {
      return updateStation != null
          ? FloatingActionButton(
              onPressed: () {
                searchController.clear();
                updateStation();
              },
              tooltip: 'Trova i benzinai in zona',
              child: new Icon(Icons.my_location),
            )
          : Container();
    });

    final searchField =
        new StoreConnector<AppState, ValueChanged<String>>(converter: (store) {
      return store.state.backendState.hasLocationPermission
          ? (text) => store.dispatch(fetchStationsByPlaceNameAction(text))
          : null;
    }, builder: (context, searchStationCallback) {
      return SearchField(
        onSearch: searchStationCallback,
        textController: searchController,
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
      floatingActionButton: floatingButton,
      resizeToAvoidBottomInset: false,
    );
  }
}

class LocationPageVm {
  final LocationState state;
  final IntCallback onStationTap;
  final bool hasLocationPermission;
  final VoidCallback onRequestLocationPermission;

  LocationPageVm(
      {@required this.state,
      @required this.onStationTap,
      @required this.hasLocationPermission,
      @required this.onRequestLocationPermission});
}
