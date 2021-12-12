import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  final TextEditingController textController;
  final String placeholder;
  final bool enabled;

  SearchField({this.onSearch, required this.textController, this.placeholder = 'Cerca un luogo...', this.enabled = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText:
            this.placeholder,
        filled: false,
        suffixIcon: Icon(Icons.search),
        border: InputBorder.none,
      ),
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      controller: textController,
      onSubmitted: this.onSearch,
      textInputAction: TextInputAction.search,
      enabled: enabled,
    );
  }
}
