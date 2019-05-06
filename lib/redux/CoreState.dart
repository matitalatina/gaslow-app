import 'package:meta/meta.dart';

class CoreState {
  bool isLoading;
  bool hasLocationPermission;

  CoreState({@required this.isLoading, @required this.hasLocationPermission});
}

CoreState getDefaultCoreState() {
  return CoreState(isLoading: false, hasLocationPermission: true);
}