import 'dart:math';

import 'package:gaslow_app/models/MyLocation.dart';
import 'package:meta/meta.dart';

class DistanceUtils {
  static calc({@required MyLocation from, @required MyLocation to}) {
    return calculateDistanceKm(from.coordinates[1], from.coordinates[0], to.coordinates[1], to.coordinates[0]);
  }

  static double calculateDistanceKm(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}
