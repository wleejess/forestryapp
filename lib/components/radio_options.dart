import "package:flutter/material.dart";

/// Widget for creating radio options, can be reused in different pages.
class RadioOptions extends StatefulWidget {
  final String header;
  final List<dynamic> enumValues;
  final dynamic initialValue;
  final dynamic Function(dynamic selectedValue) onSelected;
  final String helperText;

  /// Create a list of radio buttons from a given enum.
  ///
  /// Label the entire group of radio buttons with [header]. Values that radio
  /// buttons can take are dictated by [enumValues] where the initial value is
  /// set by [initialValue]. Pass an additional action when tapped using
  /// [onSelected].
  const RadioOptions({
    required this.header,
    required this.enumValues,
    required this.initialValue,
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
  late dynamic selectedOption;

  @override
  void initState() {
    selectedOption = widget.initialValue;
    super.initState();
  }

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
  /// Create the heading to label the entire group of radio buttons.
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
  /// build radio buttons from the provided enums.
  List<Widget> _createRadios(BuildContext context) {
    // Uses Dart's control-flow operator "collection for" (similar to a Python
    // list comprehension). See
    // https://dart.dev/language/collections#control-flow-operators.
    return [
      for (var enumValue in widget.enumValues)
        RadioListTile<dynamic>(
          title: Text(enumValue.label),
          value: enumValue,
          groupValue: selectedOption,
          onChanged: _onChanged,
        ),
    ];
  }

  /// Callback to execute when `RadioListTile` is tapped.
  void _onChanged(tappedValue) {
    setState(() {
      selectedOption = tappedValue;
      widget.onSelected(tappedValue);
    });
  }

  // Helper text ///////////////////////////////////////////////////////////////
  Text _buildHelperText(BuildContext context) {
    return Text(
      widget.helperText,
      style: Theme.of(context).inputDecorationTheme.helperStyle,
    );
  }
}
