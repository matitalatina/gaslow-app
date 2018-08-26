import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/Location.dart';
import 'package:gaslow_app/utils/DistanceUtils.dart';
import 'package:gaslow_app/widgets/StationBrandLogo.dart';
import 'package:gaslow_app/widgets/StationPriceList.dart';
import 'package:intl/intl.dart';

class StationTile extends StatelessWidget {
  final GasStation station;
  final VoidCallback onTap;
  final Location fromLocation;

  StationTile(
      {@required this.station, @required this.onTap, this.fromLocation});

  @override
  Widget build(BuildContext context) {
    final DateTime lastUpdate = station.prices
        .map((p) => p.updatedAt)
        .reduce((d1, d2) => d1.isAfter(d2) ? d1 : d2);

    final Widget distanceWidget = fromLocation != null
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.map,
              size: 15.0,
            ),
            Text(
              " " +
                  NumberFormat("0.#", "it-IT").format(DistanceUtils.calc(
                      from: fromLocation, to: station.location)) +
                  "Km",
            ),
          ])
        : Container();

    final Widget lastUpdateWidget =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.access_time,
        size: 15.0,
      ),
      Text(DateFormat(' dd-MM-yyyy').format(lastUpdate)),
    ]);
    return Card(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        elevation: 4.0,
        child: Column(children: [
          ListTile(
            dense: true,
            leading: StationBrandLogo(
              brand: station.brand,
            ),
            title: Text(station.address + ", " + station.city),
            subtitle: Text(station.brand),
            trailing: Icon(
              Icons.directions,
              color: Theme.of(context).primaryColor,
            ),
            onTap: onTap,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 15.0),
              child: Column(
                children: <Widget>[
                  StationPriceList(
                    prices: station.prices,
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: Opacity(
                opacity: 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    distanceWidget,
                    lastUpdateWidget,
                  ],
                ),
              ))
        ]));
  }
}
