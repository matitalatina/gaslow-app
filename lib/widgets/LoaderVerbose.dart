import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoaderVerbose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RotateAnimatedTextKit(
                  duration: Duration(seconds: 15),
                  text: [
                    "Determinando la tua posizione",
                    "Trovando le stazioni più vicine",
                    "Recuperando le stazioni più aggiornate",
                    "Aggregando i dati trovati",
                    "Ordinando le stazioni in ordine di prezzo",
                    "Posizionando le stazioni sulla mappa",
                    "Rimuovendo i dati obsoleti"
                  ]..shuffle(),
                  textStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).primaryColor.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                  alignment: AlignmentDirectional.center // or Alignment.topLeft
              ),
            ],
          ),
        ),
      ],);
  }
}
