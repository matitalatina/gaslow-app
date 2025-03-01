import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LoaderVerbose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const List<String> phrases = [
      "Determinando la tua posizione",
      "Trovando le stazioni più vicine",
      "Recuperando le stazioni più aggiornate",
      "Aggregando i dati trovati",
      "Ordinando le stazioni in ordine di prezzo",
      "Posizionando le stazioni sulla mappa",
      "Rimuovendo i dati obsoleti"
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            child: AnimatedTextKit(
              repeatForever: true,
              pause: Duration(),
              isRepeatingAnimation: true,
              animatedTexts: phrases
                  .map((s) => RotateAnimatedText(s,
                      textAlign: TextAlign.center,
                      alignment: AlignmentDirectional.center,
                      duration: Duration(milliseconds: 1500),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.7))))
                  .toList()
                ..shuffle(),
            ),
          ),
        ),
      ],
    );
  }
}
