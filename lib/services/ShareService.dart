import 'package:flutter/material.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/utils/StationUtils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class ShareService {
  final FirebaseAnalytics analytics;

  const ShareService({required this.analytics});

  shareStation(GasStation station, {required BuildContext context}) async {
    await SharePlus.instance.share(
      ShareParams(
        text: 'A ${station.name}, ${station.brand}, il carburante costa:\n\n' +
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
            getGoogleMapsUrl(station).toString() +
            '\nL\'ho scoperto grazie a GasLow!',
        subject: 'Risparmia sul carburante · GasLow',
        sharePositionOrigin: Rect.fromLTWH(
            0,
            0,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 2),
      ),
    );
    await analytics.logShare(
        contentType: 'station',
        itemId: '${station.id}',
        method: 'share_dialog');
  }

  shareApp({required BuildContext context}) async {
    await SharePlus.instance.share(
      ShareParams(
        text: "Ho pensato che potresti risparmiare anche tu con questa app. Scarica GasLow!\n\n" +
            "https://play.google.com/store/apps/details?id=it.mattianatali.gaslowapp&hl=it",
        subject: "Sto risparmiando sul carburante con GasLow",
        sharePositionOrigin: Rect.fromLTWH(
            0,
            0,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 2),
      ),
    );
    await analytics.logShare(
        contentType: 'app', itemId: 'gaslow', method: 'share_dialog');
  }
}
