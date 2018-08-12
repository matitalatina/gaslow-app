import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasPrice.dart';
import 'package:gaslow_app/widgets/StationPriceTile.dart';

class StationPriceList extends StatelessWidget {
  final List<GasPrice> prices;

  StationPriceList({@required this.prices});

  @override
  Widget build(BuildContext context) {
    final isSelfPrices = prices.where((p) => p.isSelf).toList();
    final servedPrices = prices.where((p) => !p.isSelf).toList();
    return Row(children: [
      Expanded(
          child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        runSpacing: 20.0,
        spacing: 20.0,
        direction: Axis.horizontal,
        children: (isSelfPrices + servedPrices)
            .map((p) => StationTile(price: p))
            .toList(),
      ))
    ]);
  }
}
