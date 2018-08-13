import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).accentColorBrightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark;
    return isLoading
        ? IconButton(
            icon: Icon(Icons.hourglass_empty),
            color: textColor,
            onPressed: null,
          )
        : IconButton(
            icon: icon,
            color: textColor,
            onPressed: onPressed,
          );
  }

  LoadingButton(
      {@required this.isLoading,
      @required this.onPressed,
      @required this.icon});
}
