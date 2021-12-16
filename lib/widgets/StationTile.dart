import 'package:flutter/material.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/MyLocation.dart';
import 'package:gaslow_app/utils/DistanceUtils.dart';
import 'package:gaslow_app/widgets/StationBrandLogo.dart';
import 'package:gaslow_app/widgets/StationPriceList.dart';
import 'package:intl/intl.dart';

typedef void IntCallback(int id);
typedef void FavoriteCallback(GasStation station, bool isFavorite);

class StationTile extends StatelessWidget {
  final GasStation station;
  final VoidCallback onMapTap;
  final MyLocation? fromLocation;
  final IntCallback onStationTap;
  final IntCallback? onShareTap;
  final bool isFavorite;
  final FavoriteCallback onFavoriteChange;

  StationTile({required this.station,
    required this.onMapTap,
    this.fromLocation,
    required this.onStationTap,
    this.onShareTap,
    required this.isFavorite,
    required this.onFavoriteChange,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime lastUpdate = station.prices
        .map((p) => p.updatedAt)
        .reduce((d1, d2) => d1.isAfter(d2) ? d1 : d2);

    final Widget distanceWidget = fromLocation != null
        ? Opacity(
        opacity: 0.3,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.map,
            size: 15.0,
          ),
          Text(
            " " +
                NumberFormat("0.#", "it-IT").format(DistanceUtils.calc(
                    from: fromLocation!, to: station.location)) +
                "Km",
          ),
        ]))
        : Container();

    final Widget lastUpdateWidget = Opacity(
        opacity: 0.3,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.access_time,
            size: 15.0,
          ),
          Text(DateFormat(' dd-MM-yyyy').format(lastUpdate)),
        ]));

    final Widget? shareButton = onShareTap != null
        ? FlatButton(
        child: Row(children: [Icon(Icons.share), Text(" Condividi")]),
        padding: EdgeInsets.all(0.0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textColor: Theme
            .of(context)
            .primaryColor,
        onPressed: () => onShareTap != null ? onShareTap!(station.id) : null)
        : null;
    final Widget favoriteButton = IconButton(onPressed: () => onFavoriteChange(station, !isFavorite), icon: Icon(isFavorite ? Icons.favorite: Icons.favorite_outline));
    return Card(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        elevation: 4.0,
        child: InkWell(
            borderRadius: BorderRadius.circular(4.0),
            onTap: () => onStationTap(station.id),
            child: Column(children: [
              ListTile(
                dense: true,
                leading: StationBrandLogo(
                  brand: station.brand,
                ),
                title: Text(station.address + ", " + station.city),
                subtitle: Text(station.brand),
                trailing: IconButton(
                  icon: Icon(Icons.directions),
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: onMapTap,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 15.0),
                child: StationPriceList(
                  prices: station.prices,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: shareButton != null ? 8.0 : 15.0,
                      horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget?>[
                      lastUpdateWidget,
                      distanceWidget,
                      favoriteButton,
                      shareButton,
                    ].where((w) => w != null).cast<Widget>().toList(),
                  ))
            ])));
  }
}
