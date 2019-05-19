import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _PREFERRED_FUEL_KEY = "SETTINGS.PREFERRED_FUEL";

class SettingsService {
  static Future<void> savePreferredFuelType(FuelTypeEnum fuelType) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_PREFERRED_FUEL_KEY, FuelTypeEnumHelper.serialize(fuelType));
  }

  static Future<FuelTypeEnum> getPreferredFuelType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return FuelTypeEnumHelper.deserialize(
        prefs.getString(_PREFERRED_FUEL_KEY) ?? "GASOLINE");
  }
}
