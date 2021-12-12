import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/services/ReviewService.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'LocationPage.dart';
import 'RoutePage.dart';

import 'SettingsPage.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;
  InterstitialAd interstitialAd;

  final _widgetOptions = [
    LocationPage(title: 'GasLow'),
    RoutePage(title: 'GasLow'),
    SettingsPage(),
  ];

  @override
  void initState() {
    _loadAdmob();
    getIt<ReviewService>().handleDeferredReview(context);
    super.initState();
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    interstitialAd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).canvasColor,
        unselectedItemColor: Theme.of(context).hintColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Dintorni'),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'Tragitto'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Impostazioni'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadAdmob() async {
    await Future.delayed(Duration(minutes: 1, seconds: 30));
    if (interstitialAd == null) {
      _loadInterstitialAd();
    }
  }

  _loadInterstitialAd() {
    return InterstitialAd.load(
      adUnitId: kReleaseMode ? 'ca-app-pub-7145772846945296/9083312901' : InterstitialAd.testAdUnitId,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (Ad ad) {
          interstitialAd = ad;
          interstitialAd.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
      request: AdRequest()
    );
  }
}