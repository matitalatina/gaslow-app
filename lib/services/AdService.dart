import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final _ADS_THROTTLE = 3;

class AdService {
  InterstitialAd? interstitialAd;
  int counter = 0;
  bool isAdShown = false;

  Future<InitializationStatus> initialize() async {
    return await MobileAds.instance.initialize();
  }

  Future<void> show() async {
    if (counter % _ADS_THROTTLE != 0) {
      countAd();
      return;
    }
    final completer = Completer<void>();
    InterstitialAd.load(
        adUnitId: kReleaseMode
            ? 'ca-app-pub-7145772846945296/9083312901'
            : InterstitialAd.testAdUnitId,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) async {
            shouldDispose();
            interstitialAd = ad;
            await ad.show();
            isAdShown = true;
            completer.complete();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
            completer.completeError(error);
          },
        ),
        request: AdRequest());
    countAd();
    return completer.future;
  }

  void countAd() {
    if (isAdShown) {
      isAdShown = false;
      return;
    }
    counter++;
  }

  void shouldDispose() async {
    interstitialAd?.dispose();
  }

}