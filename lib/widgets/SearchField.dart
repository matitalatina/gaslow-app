import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void StringCallback(String text);

class SearchField extends StatefulWidget {
  final StringCallback onSearch;

  SearchField({this.onSearch});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cerca un luogo...',
        filled: false,
        suffixIcon: Icon(Icons.search, color: Theme.of(context).highlightColor,),
        border: InputBorder.none,
        hintStyle: TextStyle(color: Theme.of(context).highlightColor),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      ),
      style: Theme.of(context).accentTextTheme.subhead,
      controller: textController,
      onSubmitted: this.widget.onSearch,
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
