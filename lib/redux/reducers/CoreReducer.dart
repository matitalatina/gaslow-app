import 'package:gaslow_app/redux/CoreState.dart';
import 'package:gaslow_app/redux/actions/CoreActions.dart';

CoreState coreReducer(CoreState state, dynamic action) {
  if (action is UpdateStationsStart) {
    return CoreState(isLoading: true, hasLocationPermission: state.hasLocationPermission);
  }
  else if (action is UpdateStationsSuccess) {
    return CoreState(isLoading: false, hasLocationPermission: state.hasLocationPermission);
  }
  else if (action is UpdateLocationPermission) {
    return CoreState(isLoading: state.isLoading, hasLocationPermission: action.hasLocationPermission);
  }
  return CoreState(isLoading: state.isLoading, hasLocationPermission: state.hasLocationPermission);
}