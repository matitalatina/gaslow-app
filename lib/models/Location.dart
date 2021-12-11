import 'package:meta/meta.dart';

class MyLocation {
  String type;
  List<double> coordinates;

  MyLocation({this.type, this.coordinates});

  factory MyLocation.fromJson(Map json) {
    return MyLocation(
      type: json['type'],
      coordinates: (json['coordinates'] as List).cast<double>(),
    );
  }

  static fromPoint({@required double latitude, @required double longitude}) {
    return MyLocation(
      type: "Point",
      coordinates: [longitude, latitude],
    );
  }

  double get latitude => coordinates[1];
  double get longitude => coordinates[0];

}
