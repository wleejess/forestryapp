import "package:flutter/material.dart";

/// Widget for creating dropdown options, can be reused in different pages.
class DropdownOptions extends StatefulWidget {
  final String header;
  final List<dynamic> enumValues;
  final dynamic initialValue;
  final dynamic Function(dynamic selectedValue) onSelected;
  final String helperText;

  /// Create a dropdown list from a given enum.
  ///
  /// Label the dropdown with [header]. Values that the dropdown can take are
  /// dictated by [enumValues] where the initial value is set by [initialValue].
  /// Pass an additional action when an item is selected using [onSelected].
  const DropdownOptions({
    required this.header,
    required this.enumValues,
    required this.initialValue,
    required this.onSelected,
    this.helperText = "",
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownOptions> createState() => _DropdownOptionsState();
}

class _DropdownOptionsState extends State<DropdownOptions> {
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
        _createDropdown(context),
        _buildHelperText(context),
      ],
    );
  }

  // Header ////////////////////////////////////////////////////////////////////
  /// Create the heading to label the entire dropdown.
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

  // Dropdown //////////////////////////////////////////////////////////////////
  /// Build the dropdown button based on the provided enums.
  Widget _createDropdown(BuildContext context) {
    return DropdownButton<dynamic>(
      value: selectedOption,
      onChanged: _onChanged,
      items: widget.enumValues.map<DropdownMenuItem<dynamic>>((dynamic value) {
        return DropdownMenuItem<dynamic>(
          value: value,
          child: Text(value.label),
        );
      }).toList(),
    );
  }

  /// Callback to execute when an item is selected from the dropdown.
  void _onChanged(dynamic newValue) {
    setState(() {
      selectedOption = newValue;
      widget.onSelected(newValue);
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
