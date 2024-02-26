import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';

class OtherIssuesForm extends StatelessWidget {
  static const _title = "Other Issues";
  static const _otherDescription =
      "Describe any other health related issues you observed.";

  const OtherIssuesForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        title: OtherIssuesForm._title,
        body: FormScaffold(
          child: _buildDescription(context),
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    final otherIssuesData = Provider.of<Area>(context);

    return FreeTextBox(
        labelText: OtherIssuesForm._title,
        helperText: OtherIssuesForm._otherDescription,
        onChanged: (text) {
          otherIssuesData.otherIssues = text;
        });
  }
}
