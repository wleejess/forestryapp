import "package:flutter/material.dart";

/// Widget for creating radio options, can be reused in different pages.

class RadioOptions extends StatefulWidget {
  final String? header;
  final List<String> options;
  final void Function(int) onSelected;
  final String labelText;
  final String helperText;

  const RadioOptions({
    this.header,
    required this.labelText,
    required this.options,
    required this.onSelected,
    this.helperText = "",
    super.key,
  });

  // For state we can use a generic of `State` to avoid linter complaining about
  // private type in public API.  https://stackoverflow.com/a/72567005
  @override
  State<RadioOptions> createState() => _RadioOptionsState();
}

class _RadioOptionsState extends State<RadioOptions> {
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText,
            style: Theme.of(context).inputDecorationTheme.helperStyle),
        ...List.generate(
          widget.options.length,
          (index) => RadioListTile<int>(
            title: Text(widget.options[index]),
            value: index,
            groupValue: selectedOption,
            onChanged: (int? value) {
              setState(
                () {
                  selectedOption = value!;
                  widget.onSelected(selectedOption);
                },
              );
            },
          ),
        ),
        Text(
          widget.helperText,
          style: Theme.of(context).inputDecorationTheme.helperStyle,
        ),
      ],
    );
  }
}
