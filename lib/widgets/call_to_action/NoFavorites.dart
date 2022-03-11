import 'package:flutter/material.dart';
import 'package:gaslow_app/widgets/call_to_action/CallToAction.dart';

class NoFavorites extends StatelessWidget {
  NoFavorites();

  @override
  Widget build(BuildContext context) {
    return CallToAction(
      icon: Icons.favorite_outline,
      description: 'Nessuna stazione preferita.\n\nAggiungile dal tab "Dintorni" o "Tragitto"',
    );
  }
}
