import 'package:flutter/material.dart';

enum FuelTypeEnum {
  GASOLINE,
  DIESEL,
  OTHER,
}

class FuelTypeEnumHelper {
  static String getLabel(FuelTypeEnum fuelType) {
    switch (fuelType) {
      case FuelTypeEnum.GASOLINE:
        return "Benzina";
      case FuelTypeEnum.DIESEL:
        return "Gasolio";
      case FuelTypeEnum.OTHER:
        return "Altro";
      default:
        return "Sconosciuto";
    }
  }
  
  static MaterialColor getColor(FuelTypeEnum fuelType) {
    switch (fuelType) {
      case FuelTypeEnum.GASOLINE:
        return Colors.lightGreen;
      case FuelTypeEnum.DIESEL:
        return Colors.yellow;
      case FuelTypeEnum.OTHER:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  static String serialize(FuelTypeEnum fuelType) {
    switch (fuelType) {
      case FuelTypeEnum.GASOLINE:
        return "GASOLINE";
      case FuelTypeEnum.DIESEL:
        return "DIESEL";
      case FuelTypeEnum.OTHER:
        return "OTHER";
      default:
        return "UNKNOWN";
    }
  }

  static FuelTypeEnum deserialize(String? str) {
    if (str == null) {
      return FuelTypeEnum.OTHER;
    } else if (str == "DIESEL") {
      return FuelTypeEnum.DIESEL;
    } else if (str == "GASOLINE") {
      return FuelTypeEnum.GASOLINE;
    }
    return FuelTypeEnum.OTHER;
  }
}
