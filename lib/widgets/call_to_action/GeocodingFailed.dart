import 'package:flutter/material.dart';

import 'package:gaslow_app/widgets/call_to_action/CallToAction.dart';

class GeocodingFailed extends StatelessWidget {
  GeocodingFailed();

  @override
  Widget build(BuildContext context) {
    return CallToAction(
      icon: Icons.not_listed_location,
      description: "Nessuna posizione trovata per il luogo cercato",
    );
  }
}
