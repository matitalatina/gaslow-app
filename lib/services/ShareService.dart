import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/utils/StationUtils.dart';
import 'package:share/share.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class ShareService {
  final FirebaseAnalytics analytics;

  const ShareService({this.analytics});

  shareStation(GasStation station) async {
    await Share.share(
      'A ${station.name}, ${station.brand}, il carburante costa:\n\n' +
          station.prices
              .map((p) =>
                  '  • ' +
                  p.fuelType +
                  (p.isSelf ? '' : ' (servito)') +
                  ': € ' +
                  getNumberFormat().format(p.price) +
                  '\n')
              .join() +
          '\n---\n' +
          'Si trova in ${station.address}\n' +
          getGoogleMapsUrl(station) +
          '\nL\'ho scoperto grazie a GasLow!',
      subject: 'Risparmia sul carburante · GasLow',
    );
    await analytics.logShare(
        contentType: 'station',
        itemId: '${station.id}',
        method: 'share_dialog'
    );
  }

  shareApp() async {
    await Share.share("Ho pensato che potresti risparmiare anche tu con questa app. Scarica GasLow!\n\n" +
        "https://play.google.com/store/apps/details?id=it.mattianatali.gaslowapp&hl=it",
      subject: "Sto risparmiando sul carburante con GasLow"
    );
    await analytics.logShare(
        contentType: 'app',
        itemId: 'gaslow',
        method: 'share_dialog'
    );
  }
}
