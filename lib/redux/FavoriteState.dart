import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/ErrorType.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/repos/FavoriteRepo.dart';

class FavoriteState {
  final bool isLoading;
  final Set<int> stationIds;
  final Set<GasStation> stations;
  final int? selectedStation;
  final ErrorType error;

  FavoriteState({
    required this.isLoading,
    required this.stationIds,
    required this.stations,
    required this.selectedStation,
    required this.error,
  });
}

Future<FavoriteState> getDefaultFavoriteState() async {
  final favoriteRepo = getIt<FavoriteRepo>();
  return FavoriteState(
    isLoading: false,
    stationIds: await favoriteRepo.getStationIds(),
    stations: Set<GasStation>.from([]),
    selectedStation: null,
    error: ErrorType.NONE,
  );
}