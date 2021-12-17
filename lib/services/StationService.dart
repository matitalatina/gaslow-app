import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/services/AdService.dart';
import 'package:gaslow_app/utils/StationUtils.dart';
import 'package:url_launcher/url_launcher.dart';

class StationService {
  final FirebaseAnalytics firebaseAnalytics;

  const StationService({required this.firebaseAnalytics});

  openMap(GasStation station) async {
    var url = getGoogleMapsUrl(station);
    if (await canLaunch(url)) {
      await launch(url);
    }
    await firebaseAnalytics.logViewItem(
        itemId: '${station.id}',
        itemName: 'directions',
        itemCategory: 'station');
  }
}
