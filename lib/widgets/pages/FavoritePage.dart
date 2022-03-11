import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/redux/MyAppState.dart';
import 'package:gaslow_app/redux/FavoriteState.dart';
import 'package:gaslow_app/redux/actions/CoreActions.dart';
import 'package:gaslow_app/redux/actions/FavoriteStationsActions.dart';
import 'package:gaslow_app/redux/selectors/FavoriteSelectors.dart';
import 'package:gaslow_app/services/ShareService.dart';
import 'package:gaslow_app/widgets/StationMapList.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:gaslow_app/widgets/call_to_action/NoConnection.dart';
import 'package:gaslow_app/widgets/call_to_action/NoFavorites.dart';
import 'package:gaslow_app/widgets/call_to_action/NoLocationPermission.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final stationList = new StoreConnector<MyAppState, FavoritePageVm>(
      converter: (store) => FavoritePageVm(
        state: store.state.favoriteState,
        preferredFuelType: store.state.settingsState.preferredFuelType,
        onRefresh: () => store.dispatch(refreshFavoriteLocations),
        onStationTap: (stationId) =>
            store.dispatch(FavoriteSelectStationAction(stationId: stationId)),
        hasLocationPermission: store.state.backendState.hasLocationPermission,
        onRequestLocationPermission: () =>
            store.dispatch(checkLocationPermissionAndFetchStations),
        onFavoriteChange: (station, isFavorite) {
          store.dispatch(isFavorite ? addFavoriteStation(station) : removeFavoriteStation(station.id));
        },
        favoriteStationIds: store.state.favoriteState.stationIds,
      ),
      builder: (context, homeVm) {
        var favoriteState = homeVm.state;
        var stations = getFavoriteStationsSortedByPrice(
            favoriteState, homeVm.preferredFuelType);
        var selectedStation = getFavoriteSelectedStation(favoriteState);

        if (!homeVm.hasLocationPermission) {
          return NoLocationPermission(
              onRequestPermission: homeVm.onRequestLocationPermission);
        }

        if (homeVm.state.error == ErrorType.CONNECTION) {
          return NoConnection(onRetry: homeVm.onRefresh);
        }

        if (homeVm.state.stationIds.length == 0) {
          return NoFavorites();
        }

        if (homeVm.state.stations.length != homeVm.state.stationIds.length) {
          homeVm.onRefresh();
        }

        return StationMapList(
          stations: stations,
          isLoading: favoriteState.isLoading,
          fromLocation: null,
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
      return store.state.backendState.hasLocationPermission && store.state.favoriteState.stations.length != 0
          ? () => store.dispatch(refreshFavoriteLocations)
          : null;
    }, builder: (context, updateStation) {
      return updateStation != null
          ? FloatingActionButton(
        onPressed: () {
          updateStation();
        },
        tooltip: 'Ricarica',
        child: new Icon(Icons.refresh),
      )
          : Container();
    });

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        //title: new GaslowTitle(title: widget.title),
        //actions: <Widget>[backendRefreshButton],
        title: Text("Preferiti")
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: stationList,
      floatingActionButton: floatingButton,
      resizeToAvoidBottomInset: false,
    );
  }
}

class FavoritePageVm {
  final FavoriteState state;
  final FuelTypeEnum preferredFuelType;
  final IntCallback onStationTap;
  final VoidCallback onRefresh;
  final bool hasLocationPermission;
  final VoidCallback onRequestLocationPermission;
  final FavoriteCallback onFavoriteChange;
  final Set<int> favoriteStationIds;

  FavoritePageVm({
    required this.state,
    required this.preferredFuelType,
    required this.onStationTap,
    required this.onRefresh,
    required this.hasLocationPermission,
    required this.onRequestLocationPermission,
    required this.onFavoriteChange,
    required this.favoriteStationIds,
  });
}
