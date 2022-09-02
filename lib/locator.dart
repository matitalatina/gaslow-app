import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gaslow_app/repos/FavoriteRepo.dart';
import 'package:gaslow_app/services/AdService.dart';
import 'package:gaslow_app/services/FavoriteService.dart';
import 'package:gaslow_app/services/ReviewService.dart';
import 'package:gaslow_app/services/ShareService.dart';
import 'package:gaslow_app/services/StationService.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

initializeServiceLocator() async {
  await Firebase.initializeApp();
  getIt.registerSingleton(FirebaseAnalytics.instance);
  getIt.registerSingleton(FavoriteRepo());
  getIt.registerSingleton(AdService());
  getIt.registerSingleton(FavoriteService(favoriteRepo: getIt<FavoriteRepo>()));
  getIt.registerSingleton(StationService(
    firebaseAnalytics: getIt<FirebaseAnalytics>(),
  ));
  getIt.registerLazySingleton(() => ShareService(
        analytics: getIt.get<FirebaseAnalytics>(),
      ));
  getIt.registerLazySingleton(() => ReviewService(
        analytics: getIt.get<FirebaseAnalytics>(),
      ));
}
