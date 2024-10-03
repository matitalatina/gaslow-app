import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final _ADS_THROTTLE = 3;

class AdService {
  InterstitialAd? interstitialAd;
  int counter = 0;
  bool isAdShown = false;

  Future<void> initialize() async {
    MobileAds.instance.initialize();
    // ConsentInformation.instance.reset();
    // ConsentDebugSettings debugSettings = ConsentDebugSettings(
    //     debugGeography: DebugGeography.debugGeographyEea,
    //     testIdentifiers: ['test']);
    final params = ConsentRequestParameters();

    ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
      log('UMP Success');
      if (await ConsentInformation.instance.isConsentFormAvailable()) {
        log('UMP Load thing');
        loadForm();
      }
    }, (error) {
      log('UMP Error, nothing to show here.');
    });
  }

  void loadForm() {
    log('UMP loadForm');
    ConsentForm.loadAndShowConsentFormIfRequired((formError) async {
      if (formError != null) {
        log('UMP loadAndShow Error');
        loadForm();
        return;
      }

      log('UMP loadAndShow no Error');

      switch (await ConsentInformation.instance
          .getPrivacyOptionsRequirementStatus()) {
        case PrivacyOptionsRequirementStatus.notRequired:
          log('UMP PrivacyOptionsRequirementsStatus is Not Required');
          break;
        case PrivacyOptionsRequirementStatus.required:
          log('UMP PrivacyOptionsRequirementsStatus is Required');
          await ConsentForm.showPrivacyOptionsForm((formError) {
            if (formError != null) {
              log('UMP PrivacyOptions Form error');
              return;
            }
            log('UMP PrivacyOptions Shown happily?');
          });
          break;
        case PrivacyOptionsRequirementStatus.unknown:
          log('UMP PrivacyOptionsRequirementsStatus is Unknown');
          break;
        default:
          log('UMP What?');
      }
    });
  }

  Future<void> show() async {
    if (counter % _ADS_THROTTLE != 0) {
      countAd();
      return;
    }
    final completer = Completer<void>();
    if (await ConsentInformation.instance.canRequestAds()) {
      InterstitialAd.load(
          adUnitId: kReleaseMode
              ? (Platform.isAndroid
              ? 'ca-app-pub-7145772846945296/9083312901'
              : 'ca-app-pub-7145772846945296/3964454999')
              : 'ca-app-pub-3940256099942544/1033173712',
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
    } else {
      completer.complete();
    }
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
