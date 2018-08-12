import 'package:gaslow_app/redux/BackendState.dart';
import 'package:gaslow_app/redux/actions/BackendStations.dart';

BackendState backendReducer(BackendState state, dynamic action) {
  if (action is UpdateStationsStart) {
    return BackendState(isLoading: true);
  }
  else if (action is UpdateStationsSuccess) {
    return BackendState(isLoading: false);
  }
  return BackendState(isLoading: state.isLoading);
}