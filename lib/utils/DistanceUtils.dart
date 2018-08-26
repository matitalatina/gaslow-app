import 'package:gaslow_app/models/Location.dart';
import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';

class DistanceUtils {
  static calc({@required Location from, @required Location to}) {
    return Distance().as(
          LengthUnit.Meter,
          LatLng(from.coordinates[1], from.coordinates[0]),
          LatLng(to.coordinates[1], to.coordinates[0]),
        ) /
        1000;
  }
}
