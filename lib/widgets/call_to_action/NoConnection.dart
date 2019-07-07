import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:gaslow_app/widgets/call_to_action/CallToAction.dart';

class NoConnection extends StatelessWidget {
  final VoidCallback onRetry;

  NoConnection({this.onRetry});

  @override
  Widget build(BuildContext context) {
    return CallToAction(
      icon: Icons.signal_cellular_off,
      description: "Non riesco a recuperare i dati in questo momento",
      onAction: onRetry,
      actionLabel: "RIPROVA",
    );
  }
}
