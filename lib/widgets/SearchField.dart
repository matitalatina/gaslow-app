import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void StringCallback(String text);

class SearchField extends StatelessWidget {
  final StringCallback onSearch;
  final textController;

  SearchField({this.onSearch, @required this.textController});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).accentColorBrightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark;
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cerca un luogo...',
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
