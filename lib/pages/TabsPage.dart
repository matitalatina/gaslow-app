import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/services/ReviewService.dart';
import 'package:gaslow_app/utils/Secrets.dart';

import 'LocationPage.dart';
import 'RoutePage.dart';
import 'package:firebase_admob/firebase_admob.dart';

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

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: ['cars', 'fuel', 'suv'],
      testDevices: [],
  );


  @override
  void initState() {
    _loadAdmob();
    getIt<ReviewService>().handleDeferredReview(context);
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    interstitialAd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styledNavigationBar = new Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).accentColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).canvasColor,
          // sets the inactive color of the `BottomNavigationBar`
          textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Theme.of(context).hintColor))),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.location_on), title: Text('Dintorni')),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), title: Text('Tragitto')),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Impostazioni')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );

    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions
        ),
      ),
      bottomNavigationBar: styledNavigationBar,
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
      await FirebaseAdMob.instance.initialize(
          appId: await Secrets.getAdmobAppId());
      interstitialAd = _loadInterstitialAd()
        ..load()
        ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
      );
    }
  }

  _loadInterstitialAd() {
    return InterstitialAd(
      adUnitId: kReleaseMode ? 'ca-app-pub-7145772846945296/9083312901' : InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
    );
  }
}