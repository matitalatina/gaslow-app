import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final TextEditingController textController;
  final String placeholder;

  SearchField({this.onSearch, @required this.textController, this.placeholder});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).accentColorBrightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark;
    return TextField(
      decoration: InputDecoration(
        hintText: this.placeholder != null ? this.placeholder : 'Cerca un luogo...',
        filled: false,
        suffixIcon: Icon(Icons.search, color: textColor,),
        border: InputBorder.none,
        hintStyle: TextStyle(color: textColor),
      ),
      style: Theme.of(context).accentTextTheme.subhead,
      controller: textController,
      onSubmitted: this.onSearch,
    );
  }
}
