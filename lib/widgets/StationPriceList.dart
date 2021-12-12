import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasPrice.dart';
import 'package:gaslow_app/widgets/StationPriceTile.dart';

class StationPriceList extends StatelessWidget {
  final List<GasPrice> prices;

  StationPriceList({required this.prices});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        runSpacing: 15.0,
        spacing: 15.0,
        direction: Axis.horizontal,
        children: prices
            .map((p) => StationTile(price: p))
            .toList(),
      ))
    ]);
  }
}
