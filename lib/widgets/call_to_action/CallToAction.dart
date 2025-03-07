import 'package:flutter/material.dart';

class CallToAction extends StatelessWidget {
  final String description;
  final VoidCallback? onAction;
  final String? actionLabel;
  final IconData icon;

  CallToAction({
    required this.description,
    this.onAction,
    this.actionLabel,
    required this.icon
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                ),
                ...(onAction != null && actionLabel != null) ? [ElevatedButton(
                  onPressed: onAction,
                  child: Text(actionLabel!),
                )] : []
              ],
            ),
          ),
        ],
      );
  }
}
