import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/utils/StationUtils.dart';

class ShareService {
  static shareStation(GasStation station) {
    Share.text(
        'Condividi stazione',
        'A ${station.name}, ${station.brand}, il carburante costa:\n\n' +
            station.prices
                .map((p) =>
                    '  • ' +
                    p.fuelType +
                    (p.isSelf ? '' : ' (servito)') +
                    ': € ' +
                    getNumberFormat().format(p.price) +
                    '\n')
                .join() +
            '\n---\n' +
            'Si trova in ${station.address}\n' +
            getGoogleMapsUrl(station) +
            '\nL\'ho scoperto grazie a GasLow!',
        'text/plain');
  }
}
