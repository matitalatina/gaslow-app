import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final TextEditingController textController;
  final String placeholder;
  final bool enabled;

  SearchField({this.onSearch, @required this.textController, this.placeholder, this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText:
            this.placeholder != null ? this.placeholder : 'Cerca un luogo...',
        filled: false,
        suffixIcon: Icon(Icons.search),
        border: InputBorder.none,
      ),
      style: Theme.of(context).accentTextTheme.subhead,
      controller: textController,
      onSubmitted: this.onSearch,
      textInputAction: TextInputAction.search,
      enabled: enabled,
    );
  }
}
