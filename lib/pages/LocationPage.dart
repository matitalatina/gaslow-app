import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/StationsState.dart';
import 'package:gaslow_app/redux/actions/FetchStations.dart';
import 'package:gaslow_app/redux/actions/UiStations.dart';
import 'package:gaslow_app/redux/selectors/StationsSelectors.dart';
import 'package:gaslow_app/widgets/MapWidget.dart';
import 'package:gaslow_app/widgets/SearchField.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:gaslow_app/widgets/StationsWidget.dart';

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
            store.dispatch(SelectStationAction(stationId: stationId)),
      ),
      builder: (context, homeVm) {
        var stationsState = homeVm.state;
        var stations = getStationsSortedByPrice(stationsState);
        var selectedStation = getSelectedStation(stationsState);
        var widgets = [
          Flexible(
              flex: 1,
              child: MapWidget(
                stations: stations,
                isLoading: stationsState.isLoading,
                fromLocation: stationsState.fromLocation,
                selectedStation: selectedStation,
                onStationTap: homeVm.onStationTap,
              )),
          Flexible(
              flex: 2,
              child: StationsWidget(
                onStationTap: homeVm.onStationTap,
                stations: stations,
                isLoading: stationsState.isLoading,
                fromLocation: stationsState.fromLocation,
                selectedStation: selectedStation,
              ))
        ];
        return MediaQuery.of(context).orientation == Orientation.portrait ?
        Column(children: widgets) : Row(children: widgets);
      },
    );

    final floatingButton =
    new StoreConnector<AppState, VoidCallback>(converter: (store) {
      return () => store.dispatch(fetchStationsByLocationAction(store));
    }, builder: (context, updateStation) {
      return FloatingActionButton(
        onPressed: () {
          searchController.clear();
          updateStation();
        },
        tooltip: 'Trova i benzinai in zona',
        child: new Icon(Icons.my_location),
      );
    });

    final searchField =
    new StoreConnector<AppState, StringCallback>(converter: (store) {
      return (text) =>
          store.dispatch(fetchStationsByPlaceNameAction(text)(store));
    }, builder: (context, searchStationCallback) {
      return SearchField(
        onSearch: searchStationCallback,
        textController: searchController,
      );
    });

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(widget.title,
            style: TextStyle(
                fontFamily: 'Syncopate', fontWeight: FontWeight.bold)),
        //actions: <Widget>[backendRefreshButton],
        bottom: PreferredSize(
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
      floatingActionButton:
      floatingButton, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class LocationPageVm {
  final StationsState state;
  final IntCallback onStationTap;

  LocationPageVm({@required this.state, @required this.onStationTap});
}