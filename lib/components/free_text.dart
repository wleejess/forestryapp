import "package:flutter/material.dart";

/// Widget for entering free text, can be reused in different pages.

class FreeTextBox extends StatelessWidget {
  final TextEditingController controller;
  // final String header;
  final String? helperText;
  final String labelText;
  final void Function(String) onChanged;

  const FreeTextBox({
    required this.controller,
    required this.labelText,
    this.helperText,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:
          null, // Setting this to null allows the TextField to expand as needed
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helperText
      ),
      onChanged: onChanged,
      controller: controller,
    );
  }
}