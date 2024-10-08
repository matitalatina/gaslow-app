import 'package:flutter/material.dart';

import 'package:gaslow_app/widgets/call_to_action/CallToAction.dart';

class NoLocationPermission extends StatelessWidget {
  final VoidCallback onRequestPermission;

  const NoLocationPermission({Key? key, required this.onRequestPermission}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CallToAction(
      icon: Icons.location_off,
      description: "Ho bisogno di sapere dove sei per aiutarti!",
      onAction: onRequestPermission,
      actionLabel: "RICHIEDI I PERMESSI",
    );
  }
}
