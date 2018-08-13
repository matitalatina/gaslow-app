import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/GasPrice.dart';

class StationTile extends StatelessWidget {
  final GasPrice price;

  StationTile({@required this.price});

//  @override
//  Widget build(BuildContext context) {
//    return Chip(
//        shape: UnderlineInputBorder(),
//        backgroundColor: price.fuelType.contains("enzin")
//            ? Colors.lightGreen
//            : Colors.yellow,
//        avatar: price.isSelf ? null : Icon(Icons.star),
//        label: Column(
//          children: [Text(price.fuelType), Text("€ " + price.price.toString())],
//        ));
//  }

  @override
  Widget build(BuildContext context) {
    MaterialColor color;
    if (price.fuelType.contains("enzin")){
      color = Colors.lightGreen;
    }
      else if (price.fuelType.contains("asolio") || price.fuelType.contains("iesel") || price.fuelType.contains("uper")) {
      color = Colors.yellow;
    } else {
      color = Colors.blue;
    }

    Color colorDark = color[900];
    TextStyle textStyle = TextStyle(color: colorDark);
    return SizedBox(
        width: 95.0,
        height: 95.0,
        child: Container(
            decoration: BoxDecoration(
              color: color[100],
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(width: 3.0,
                    color: color)),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Opacity(
                    child: price.isSelf ? Container() : Icon(Icons.star, color: color, size: 80.0,),
                  opacity: 0.3,
                ),
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(price.fuelType,textAlign: TextAlign.center, style: textStyle,),
                  Text("€ " + price.price.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: colorDark, fontSize: 18.0)),
                ],
              )],
            )));

//        shape: UnderlineInputBorder(),
//        backgroundColor: price.fuelType.contains("enzin")
//            ? Colors.lightGreen
//            : Colors.yellow,
//        avatar: price.isSelf ? null : Icon(Icons.star),
//        label: ;
  }
}
