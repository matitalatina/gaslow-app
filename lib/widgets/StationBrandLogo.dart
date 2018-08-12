import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StationBrandLogo extends StatelessWidget {
  final String brand;

  @override
  Widget build(BuildContext context) {
    final String lowerBrand = brand.toLowerCase();
    String imagePath;

    if (lowerBrand.contains("q8")) {
      imagePath = "q8.png";
    } else if (lowerBrand.contains("eni")) {
      imagePath = "eni.png";
    } else if (lowerBrand.contains("esso")) {
      imagePath = "esso.png";
    } else if (lowerBrand.contains("api")) {
      imagePath = "api.png";
    } else if (lowerBrand.contains("retitalia")) {
      imagePath = "retitalia.png";
    } else if (lowerBrand.contains("esso")) {
      imagePath = "esso.png";
    } else if (lowerBrand.contains("tamoil")) {
      imagePath = "tamoil.png";
    } else if (lowerBrand.contains("total")) {
      imagePath = "totalerg.jpg";
    }

    return imagePath != null ? Image.asset(
        "assets/station_logos/" + imagePath,
      width: 40.0,
    ) : Icon(Icons.local_gas_station, size: 40.0,);

  }

  StationBrandLogo({@required this.brand});
}
