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
}