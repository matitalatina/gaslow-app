import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gaslow_app/services/ShareService.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

initializeServiceLocator() {
  getIt.registerSingleton(FirebaseAnalytics());
  getIt.registerLazySingleton(
      () => ShareService(
          analytics: getIt.get<FirebaseAnalytics>(),
      )
  );
}
