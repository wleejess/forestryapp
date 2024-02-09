import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';

class OtherIssues extends StatelessWidget {
  final TextEditingController _otherController = TextEditingController();
  static const _title = "Other Issues";
  static const _otherDescription =
      "Describe any other health related issues you observed.";

  OtherIssues({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: FormScaffold(
        children: <Widget>[
          _buildDescription(context)
        ],
      )
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    return FreeTextBox(
      controller: _otherController, 
      labelText: _title,
      helperText: _otherDescription,
      onChanged: (text) {}
    );
  }
}
