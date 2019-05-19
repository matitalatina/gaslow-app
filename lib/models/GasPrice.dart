import 'package:gaslow_app/models/FuelTypeEnum.dart';

class GasPrice {
  String fuelType;
  FuelTypeEnum fuelTypeEnum;
  double price;
  bool isSelf;
  DateTime updatedAt;

  GasPrice({this.fuelType, this.fuelTypeEnum, this.price, this.isSelf, this.updatedAt});

  factory GasPrice.fromJson(Map json) {
    return GasPrice(
      fuelType: json['fuelType'],
      fuelTypeEnum: FuelTypeEnumHelper.deserialize(json['fuelTypeEnum']),
      price: json['price'] + .0,
      isSelf: json['isSelf'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}