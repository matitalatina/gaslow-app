import 'package:meta/meta.dart';

class Location {
  String type;
  List<double> coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map json) {
    return Location(
      type: json['type'],
      coordinates: (json['coordinates'] as List).cast<double>(),
    );
  }

  static fromPoint({@required double latitude, @required double longitude}) {
    return Location(
      type: "Point",
      coordinates: [longitude, latitude],
    );
  }

  double get latitude => coordinates[1];
  double get longitude => coordinates[0];

}
