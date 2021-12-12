import 'package:gaslow_app/models/GasPrice.dart';
import 'package:gaslow_app/models/MyLocation.dart';

class GasStation {
  int id;
  String manager;
  String brand;
  String type;
  String name;
  String address;
  String city;
  String province;
  List<GasPrice> prices;
  MyLocation location;

  GasStation({required this.id,required  this.manager,required  this.brand, required this.type,required  this.name,
    required this.address,required  this.city, required this.province,required  this.prices, required this.location});

  factory GasStation.fromJson(Map<dynamic, dynamic> json) {
    return GasStation(
      id: json['id'],
      manager: json['manager'],
      brand: json['brand'],
      type: json['type'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      province: json['province'],
      prices: (json['prices'] as List).cast<Map<String, dynamic>>().map((p) => GasPrice.fromJson(p)).toList(),
      location: MyLocation.fromJson(json['location']),
    );
  }

}