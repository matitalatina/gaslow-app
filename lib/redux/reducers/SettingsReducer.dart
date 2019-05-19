import 'package:gaslow_app/redux/actions/SettingsActions.dart';

import '../SettingsState.dart';

SettingsState settingsReducer(SettingsState state, action) {
  if (action is SetPreferredFuel) {
    return SettingsState(
      preferredFuelType: action.preferredFuel,
    );
  }
  return SettingsState(
    preferredFuelType: state.preferredFuelType,
  );
}