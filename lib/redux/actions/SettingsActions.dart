import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/services/SettingsService.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class SetPreferredFuel {
  FuelTypeEnum preferredFuel;

  SetPreferredFuel({required this.preferredFuel});
}

ThunkAction<AppState> setPreferredFuelAction(FuelTypeEnum preferredFuel) {
  return (Store<AppState> store) async {
    await SettingsService.savePreferredFuelType(preferredFuel);
    store.dispatch(SetPreferredFuel(preferredFuel: preferredFuel));
  };
}