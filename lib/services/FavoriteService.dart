import 'package:gaslow_app/repos/FavoriteRepo.dart';

class FavoriteService {
  final FavoriteRepo favoriteRepo;

  FavoriteService({required this.favoriteRepo});

  Future<Set<int>> addFavoriteStation(int stationId) async {
    final stations = await favoriteRepo.getStationIds();
    stations.add(stationId);
    await favoriteRepo.setStationIds(stations);
    return stations;
  }

  Future<Set<int>> removeFavoriteStation(int stationId) async {
    final stations = await favoriteRepo.getStationIds();
    stations.remove(stationId);
    await favoriteRepo.setStationIds(stations);
    return stations;
  }

  Future<Set<int>> setFavoriteStations(Set<int> stations) async {
    await favoriteRepo.setStationIds(stations);
    return stations;
  }
}