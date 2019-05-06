import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoLocationPermission extends StatelessWidget {
  final VoidCallback onRequestPermission;

  const NoLocationPermission({Key key, this.onRequestPermission}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
            child: Opacity(
              opacity: 0.05,
              child: Icon(
                Icons.location_off,
                size: 250.0,
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Text(
                "Ho bisogno di sapere dove sei per aiutarti!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            ),
            RaisedButton(
              onPressed: onRequestPermission,
              child: Text("RICHIEDI I PERMESSI"),
              color: Theme.of(context).accentColor,
              textTheme: ButtonTextTheme.primary,
            )
          ],
        ),
      ],
    );;
  }
}
