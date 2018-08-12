import 'package:gaslow_app/redux/AppState.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';

class UpdateStationsSuccess {}

class UpdateStationsStart {}

// ignore: strong_mode_top_level_function_literal_block
final updateStationsAction = (Store<AppState> store) async {
  store.dispatch(UpdateStationsStart());
  await post("https://gaslow.herokuapp.com/stations/update");
  store.dispatch(UpdateStationsSuccess());
};