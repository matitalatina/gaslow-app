import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/redux/AppState.dart';
import 'package:gaslow_app/redux/actions/SettingsActions.dart';
import 'package:gaslow_app/services/ShareService.dart';
import 'package:gaslow_app/widgets/PreferredFuelTile.dart';

class PreferredFuelTypeVm {
  final FuelTypeEnum value;
  final ValueChanged<FuelTypeEnum> onChange;

  PreferredFuelTypeVm({this.value, this.onChange});
}
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferredFuelType = StoreConnector<AppState, PreferredFuelTypeVm>(
      converter: (store) => PreferredFuelTypeVm(
        value: store.state.settingsState.preferredFuelType,
        onChange: (fuelType) => store.dispatch(setPreferredFuelAction(fuelType)),
      ),
      builder: (context, fuelTypeVm) => PreferredFuelTile(
        value: fuelTypeVm.value,
        onChange: fuelTypeVm.onChange,
      ),
    );
    final shareAppTile = ListTile(
      leading: Column(children: <Widget>[Icon(Icons.share)], mainAxisAlignment: MainAxisAlignment.center,),
      title: Text("Aiuta i tuoi amici"),
      subtitle: Text("Condividi l'app con loro"),
      onTap: () => getIt<ShareService>().shareApp(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Impostazioni"),
      ),
      body: ListView(
        children: <Widget>[
          preferredFuelType,
          shareAppTile,
        ],
      ),
    );
  }
}
