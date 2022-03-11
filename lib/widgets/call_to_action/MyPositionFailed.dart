import 'package:flutter/material.dart';
import 'package:gaslow_app/widgets/call_to_action/CallToAction.dart';

class MyPositionFailed extends StatelessWidget {
  final VoidCallback onRetry;

  MyPositionFailed({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return CallToAction(
      icon: Icons.gps_off,
      description: "Non sono riuscito a recuperare la tua posizione",
      onAction: onRetry,
      actionLabel: "RIPROVA",
    );
  }
}
