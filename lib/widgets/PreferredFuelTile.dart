import 'package:flutter/material.dart';
import 'package:gaslow_app/models/FuelTypeEnum.dart';

class PreferredFuelTile extends StatelessWidget {
  final FuelTypeEnum value;
  final ValueChanged<FuelTypeEnum> onChange;

  PreferredFuelTile({required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Carburante"),
      trailing: DropdownButton<FuelTypeEnum>(
        value: value,
        items: FuelTypeEnum.values
            .map((f) => DropdownMenuItem<FuelTypeEnum>(
            value: f,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: FuelTypeEnumHelper.getColor(f),
                        shape: BoxShape.circle),
                  ),
                ),
                Text(FuelTypeEnumHelper.getLabel(f)),
              ],
            )))
            .toList(),
        onChanged: (x) => x != null ? onChange(x): null,
      ),
    );
  }
}
