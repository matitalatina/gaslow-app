
class CoreState {
  final bool isLoading;
  final bool hasLocationPermission;

  CoreState({required this.isLoading, required this.hasLocationPermission});
}

CoreState getDefaultCoreState() {
  return CoreState(isLoading: false, hasLocationPermission: true);
}