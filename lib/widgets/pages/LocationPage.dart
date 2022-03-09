import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/redux/MyAppState.dart';
import 'package:gaslow_app/redux/LocationState.dart';
import 'package:gaslow_app/redux/actions/FavoriteStationsActions.dart';
import 'package:gaslow_app/redux/actions/LocationStationsActions.dart';
import 'package:gaslow_app/redux/selectors/LocationSelectors.dart';
import 'package:gaslow_app/services/ShareService.dart';
import 'package:gaslow_app/widgets/call_to_action/NoConnection.dart';
import 'package:gaslow_app/widgets/call_to_action/NoLocationPermission.dart';
import 'package:gaslow_app/widgets/SearchField.dart';
import 'package:gaslow_app/widgets/StationMapList.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:gaslow_app/redux/actions/CoreActions.dart';
import 'package:gaslow_app/locator.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key, required this.title}) : super(key: key);

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
    final stationList = new StoreConnector<MyAppState, LocationPageVm>(
      converter: (store) => LocationPageVm(
        state: store.state.stationsState,
        preferredFuelType: store.state.settingsState.preferredFuelType,
        onStationTap: (stationId) =>
            store.dispatch(LocationSelectStationAction(stationId: stationId)),
        hasLocationPermission: store.state.backendState.hasLocationPermission,
        onRequestLocationPermission: () =>
            store.dispatch(checkLocationPermissionAndFetchStations),
        onSearch: () => store.dispatch(fetchStationsByCurrentLocationAction),
        onFavoriteChange: (station, isFavorite) {
          store.dispatch(LocationSelectStationAction(stationId: station.id));
          store.dispatch(isFavorite ? addFavoriteStation(station) : removeFavoriteStation(station.id));
        },
        favoriteStationIds: store.state.favoriteState.stationIds,
      ),
      builder: (context, homeVm) {
        var stationsState = homeVm.state;
        var stations = getLocationStationsSortedByPrice(
            stationsState, homeVm.preferredFuelType);
        var selectedStation = getLocationSelectedStation(stationsState);

        if (!homeVm.hasLocationPermission) {
          return NoLocationPermission(
              onRequestPermission: homeVm.onRequestLocationPermission);
        }

        if (homeVm.state.error == ErrorType.CONNECTION) {
          return NoConnection(onRetry: homeVm.onSearch);
        }

        return StationMapList(
          stations: stations,
          isLoading: stationsState.isLoading,
          fromLocation: stationsState.fromLocation,
          selectedStation: selectedStation,
          onStationTap: homeVm.onStationTap,
          onShareTap: (stationId) => getIt<ShareService>()
              .shareStation(stations.firstWhere((s) => s.id == stationId)),
          onFavoriteChange: homeVm.onFavoriteChange,
          favoriteStationIds: homeVm.favoriteStationIds,
        );
      },
    );

    final floatingButton =
        new StoreConnector<MyAppState, VoidCallback?>(converter: (store) {
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
        new StoreConnector<MyAppState, ValueChanged<String>?>(converter: (store) {
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
  final FuelTypeEnum preferredFuelType;
  final IntCallback onStationTap;
  final bool hasLocationPermission;
  final VoidCallback onRequestLocationPermission;
  final VoidCallback onSearch;
  final FavoriteCallback onFavoriteChange;
  final Set<int> favoriteStationIds;

  LocationPageVm({
    required this.state,
    required this.preferredFuelType,
    required this.onStationTap,
    required this.hasLocationPermission,
    required this.onRequestLocationPermission,
    required this.onSearch,
    required this.onFavoriteChange,
    required this.favoriteStationIds,
  });
}
