import 'package:flutter/material.dart';

class GaslowTitle extends StatelessWidget {
  const GaslowTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Text(title,
        style: TextStyle(
            fontFamily: 'Syncopate', fontWeight: FontWeight.bold));
  }
}