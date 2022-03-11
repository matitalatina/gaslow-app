import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final ValueChanged<String>? onSearch;
  final void Function() onClear;
  final TextEditingController textController;
  final String placeholder;
  final bool enabled;

  SearchField(
      {this.onSearch,
      required this.textController,
      this.placeholder = 'Cerca un luogo...',
      this.enabled = false,
      required this.onClear});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: TextField(
        decoration: InputDecoration(
          hintText: this.widget.placeholder,
          filled: false,
          suffixIcon: isFocused
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).hintColor,
                  ),
                  onPressed: widget.onClear,
                )
              : Icon(Icons.search),
          border: InputBorder.none,
        ),
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        controller: widget.textController,
        onSubmitted: this.widget.onSearch,
        textInputAction: TextInputAction.search,
        enabled: widget.enabled,
      ),
      onFocusChange: (bool focused) {
        setState(() {
          isFocused = focused;
        });
      },
    );
  }
}
