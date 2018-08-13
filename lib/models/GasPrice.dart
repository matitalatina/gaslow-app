class GasPrice {
  String fuelType;
  double price;
  bool isSelf;
  DateTime updatedAt;

  GasPrice({this.fuelType, this.price, this.isSelf, this.updatedAt});

  factory GasPrice.fromJson(Map json) {
    return GasPrice(
      fuelType: json['fuelType'],
      price: json['price'] + .0,
      isSelf: json['isSelf'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}