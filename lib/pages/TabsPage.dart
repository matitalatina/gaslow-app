import 'package:flutter/material.dart';

import 'LocationPage.dart';
import 'RoutePage.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    LocationPage(title: 'GasLow'),
    RoutePage(title: 'GasLow'),
  ];

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
}