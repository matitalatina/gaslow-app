import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gaslow_app/repos/FavoriteRepo.dart';
import 'package:gaslow_app/services/FavoriteService.dart';
import 'package:gaslow_app/services/ReviewService.dart';
import 'package:gaslow_app/services/ShareService.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

initializeServiceLocator() {
  getIt.registerSingleton(FirebaseAnalytics());
  getIt.registerSingleton(FavoriteRepo());
  getIt.registerSingleton(FavoriteService(favoriteRepo: getIt<FavoriteRepo>()));
  getIt.registerLazySingleton(
      () => ShareService(
          analytics: getIt.get<FirebaseAnalytics>(),
      )
  );
  getIt.registerLazySingleton(
      () => ReviewService(
        analytics: getIt.get<FirebaseAnalytics>(),
      )
  );
}
