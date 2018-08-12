import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? IconButton(
            icon: Icon(Icons.hourglass_empty),
            onPressed: null,
          )
        : IconButton(
            icon: icon,
            onPressed: onPressed,
          );
  }

  LoadingButton(
      {@required this.isLoading,
      @required this.onPressed,
      @required this.icon});
}
