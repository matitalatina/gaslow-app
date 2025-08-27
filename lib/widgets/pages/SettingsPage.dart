import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/FuelTypeEnum.dart';
import 'package:gaslow_app/redux/MyAppState.dart';
import 'package:gaslow_app/redux/actions/SettingsActions.dart';
import 'package:gaslow_app/services/ReviewService.dart';
import 'package:gaslow_app/services/ShareService.dart';
import 'package:gaslow_app/widgets/PreferredFuelTile.dart';
import 'package:url_launcher/url_launcher.dart';

class PreferredFuelTypeVm {
  final FuelTypeEnum value;
  final ValueChanged<FuelTypeEnum> onChange;

  PreferredFuelTypeVm({required this.value, required this.onChange});
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferredFuelType = StoreConnector<MyAppState, PreferredFuelTypeVm>(
      converter: (store) => PreferredFuelTypeVm(
        value: store.state.settingsState.preferredFuelType,
        onChange: (fuelType) =>
            store.dispatch(setPreferredFuelAction(fuelType)),
      ),
      builder: (context, fuelTypeVm) => PreferredFuelTile(
        value: fuelTypeVm.value,
        onChange: fuelTypeVm.onChange,
      ),
    );
    final shareAppTile = ListTile(
      leading: Column(
        children: [
          Icon(
            Icons.share,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      title: Text("Aiuta i tuoi amici a risparmiare"),
      subtitle: Text("Condividi l'app"),
      onTap: () => getIt<ShareService>().shareApp(context: context),
    );
    final reviewApp = ListTile(
      leading: Column(
        children: [
          Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      title: Text("Ami risparmiare con GasLow?"),
      subtitle: Text("Condividi il tuo amore con una recensione"),
      onTap: () => getIt<ReviewService>().review(),
    );
    final privacyPolicy = ListTile(
      leading: Column(
        children: [
          Icon(
            Icons.data_usage,
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      title: Text("Politica sulla privacy"),
      onTap: () => launchUrl(
          Uri.parse("https://blog.mattianatali.dev/gaslow/privacy-policy/")),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Impostazioni"),
      ),
      body: ListView(
        children: <Widget>[
          preferredFuelType,
          shareAppTile,
          reviewApp,
          privacyPolicy,
        ],
      ),
    );
  }
}
