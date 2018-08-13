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
    } else if (lowerBrand.contains("enercoop")) {
      imagePath = "enercoop.png";
    } else if (lowerBrand.contains("repsol")) {
      imagePath = "repsol.png";
    } else if (lowerBrand.contains("edra")) {
      imagePath = "edraoil.png";
    } else if (lowerBrand.contains("enerpetroli")) {
      imagePath = "enerpetroli.png";
    } else if (lowerBrand.contains("7sette")) {
      imagePath = "7sette.jpg";
    } else if (lowerBrand.contains("europam")) {
      imagePath = "europam.png";
    } else if (lowerBrand.contains("gnp")) {
      imagePath = "gnp.png";
    }

    return imagePath != null
        ? Image.asset(
            "assets/station_logos/" + imagePath,
            width: 40.0,
          )
        : Icon(
            Icons.local_gas_station,
            size: 40.0,
          );
  }

  StationBrandLogo({@required this.brand});
}
