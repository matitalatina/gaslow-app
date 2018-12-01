import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/BackendState.dart';
import 'package:gaslow_app/redux/StationsState.dart';
import 'package:gaslow_app/redux/actions/BackendStations.dart';
import 'package:gaslow_app/redux/actions/FetchStations.dart';
import 'package:gaslow_app/redux/actions/UiStations.dart';
import 'package:gaslow_app/redux/reducers/AppStateReducer.dart';
import 'package:gaslow_app/redux/selectors/StationsSelectors.dart';
import 'package:gaslow_app/widgets/LoadingButton.dart';
import 'package:gaslow_app/widgets/MapWidget.dart';
import 'package:gaslow_app/widgets/SearchField.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:gaslow_app/widgets/StationsWidget.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: new AppState(
        stationsState:
        StationsState(isLoading: false,
            stations: [],
            fromLocation: null,
            selectedStation: null),
        backendState: BackendState(isLoading: false),
      ));
  store.dispatch(fetchStationsByLocationAction(store));
  runApp(new MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<MaterialColor> allowedColors = [
      Colors.indigo,
      Colors.red,
      Colors.cyan,
      Colors.blue,
      Colors.purple,
      Colors.teal,
      Colors.green,
      Colors.amber,
      Colors.orange,
      Colors.lightGreen,
      Colors.lightBlue,
      Colors.pink,
      Colors.lime,
    ];
    return StoreProvider<AppState>(
        store: store,
        child: new MaterialApp(
          title: 'GasLow',
          theme: new ThemeData(
            primarySwatch: allowedColors[
            Random(DateTime
                .now()
                .millisecondsSinceEpoch)
                .nextInt(allowedColors.length)],
            fontFamily: 'WorkSans',
          ),
          home: new MyHomePage(title: 'GasLow'),
        ));
  }

  MyApp({Key key, this.store}) : super(key: key);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class HomeVm {
  final StationsState state;
  final IntCallback onStationTap;

  HomeVm({@required this.state, @required this.onStationTap});
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final stationList = new StoreConnector<AppState, HomeVm>(
      converter: (store) =>
          HomeVm(
            state: store.state.stationsState,
            onStationTap: (stationId) =>
                store.dispatch(SelectStationAction(stationId: stationId)),
          ),
      builder: (context, homeVm) {
        var stationsState = homeVm.state;
        var stations = getStationsSortedByPrice(stationsState);
        var selectedStation = getSelectedStation(stationsState);
        return Column(children: [
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
        ]);
      },
    );

//    final backendRefreshButton =
//        new StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
//      return {
//        "backendState": store.state.backendState,
//        "updateBackendCallback": () =>
//            store.dispatch(updateStationsAction(store)),
//      };
//    }, builder: (context, vm) {
//      return Opacity(
//        opacity: 1.0,
//        child: LoadingButton(
//          isLoading: (vm['backendState'] as BackendState).isLoading,
//          onPressed: (vm['updateBackendCallback'] as VoidCallback),
//          icon: Icon(Icons.refresh),
//        ),
//      );
//    });

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
      backgroundColor: Theme
          .of(context)
          .primaryColorLight,
      body: stationList,
      floatingActionButton:
      floatingButton, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
