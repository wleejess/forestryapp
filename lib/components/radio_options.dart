import "package:flutter/material.dart";

/// Widget for creating radio options, can be reused in different pages.

class RadioOptions extends StatefulWidget {
  final String header;
  final List<String> options;
  final void Function(int) onSelected;
  final String helperText;

  const RadioOptions({
    required this.header,
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
        _buildOptionsHeader(),
        ..._createRadios(context),
        _buildHelperText(context),
      ],
    );
  }

  // Header ////////////////////////////////////////////////////////////////////
  Padding _buildOptionsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        widget.header,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Radio /////////////////////////////////////////////////////////////////////
  List<Widget> _createRadios(BuildContext context) {
    return [
      for (var option in widget.options)
        RadioListTile<int>(
          title: Text(option),
          value: widget.options.indexOf(option),
          groupValue: selectedOption,
          onChanged: _onChanged,
        ),
    ];
  }

  void _onChanged(int? value) {
    setState(
      () {
        selectedOption = value!;
        widget.onSelected(selectedOption);
      },
    );
  }

  // Helper text ///////////////////////////////////////////////////////////////
  Text _buildHelperText(BuildContext context) {
    return Text(
      widget.helperText,
      style: Theme.of(context).inputDecorationTheme.helperStyle,
    );
  }
}
