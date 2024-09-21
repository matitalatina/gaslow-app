import 'package:flutter/material.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/services/AdService.dart';
import 'package:gaslow_app/services/ReviewService.dart';
import 'package:gaslow_app/widgets/pages/FavoritePage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'LocationPage.dart';
import 'RoutePage.dart';

import 'SettingsPage.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();

}

class _TabsPageState extends State<TabsPage> with WidgetsBindingObserver {
  int _selectedIndex = 0;
  InterstitialAd? interstitialAd;

  final _widgetOptions = [
    LocationPage(title: 'GasLow'),
    RoutePage(title: 'GasLow'),
    FavoritePage(),
    SettingsPage(),
  ];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getIt<AdService>().show();
    }
  }

  @override
  void initState() {
    super.initState();
    getIt<ReviewService>().handleDeferredReview(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    getIt<AdService>().shouldDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).canvasColor,
        unselectedItemColor: Theme.of(context).hintColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Dintorni'),
          BottomNavigationBarItem(
              icon: Icon(Icons.timeline), label: 'Tragitto'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoriti'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Impostazioni'),
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
}
