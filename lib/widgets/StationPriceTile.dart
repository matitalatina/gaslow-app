import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/models/GasPrice.dart';
import 'package:gaslow_app/utils/StationUtils.dart';
import 'package:intl/intl.dart';

class StationTile extends StatelessWidget {
  final GasPrice price;

  StationTile({@required this.price});

  @override
  Widget build(BuildContext context) {
    MaterialColor color = FuelTypeEnumHelper.getColor(price.fuelTypeEnum);
    Color colorDark = color[900];
    TextStyle textStyle = TextStyle(color: colorDark);
    return SizedBox(
        width: 88.0,
        height: 88.0,
        child: Container(
            decoration: BoxDecoration(
                color: color[100],
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(width: 3.0, color: color)),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Opacity(
                  child: price.isSelf
                      ? Container()
                      : Icon(
                          Icons.star,
                          color: color,
                          size: 80.0,
                        ),
                  opacity: 0.3,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      price.fuelType.replaceFirst(" ", "\n"),
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                    Text("€ " + getNumberFormat().format(price.price),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorDark,
                            fontSize: 18.0)),
                  ],
                )
              ],
            )));

//        shape: UnderlineInputBorder(),
//        backgroundColor: price.fuelType.contains("enzin")
//            ? Colors.lightGreen
//            : Colors.yellow,
//        avatar: price.isSelf ? null : Icon(Icons.star),
//        label: ;
  }
}
