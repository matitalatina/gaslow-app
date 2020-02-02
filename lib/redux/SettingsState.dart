import 'package:flutter/widgets.dart';
import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/services/SettingsService.dart';
import 'package:meta/meta.dart';

class SettingsState {
  FuelTypeEnum preferredFuelType;

  SettingsState({@required this.preferredFuelType});
}

Future<SettingsState> getDefaultSettingsState() async {
  return SettingsState(
    preferredFuelType: await SettingsService.getPreferredFuelType(),
  );
}