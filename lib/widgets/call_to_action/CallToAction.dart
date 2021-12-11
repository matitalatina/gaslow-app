import 'package:flutter/material.dart';

class CallToAction extends StatelessWidget {
  final String description;
  final VoidCallback onAction;
  final String actionLabel;
  final IconData icon;

  CallToAction({
    @required this.description,
    @required this.onAction,
    @required this.actionLabel,
    @required this.icon
  });

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: <Widget>[
          Center(
              child: Opacity(
                opacity: 0.05,
                child: Icon(
                  icon,
                  size: 250.0,
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              ),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel),
              )
            ],
          ),
        ],
      );
  }
}
