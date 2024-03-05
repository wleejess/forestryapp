import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:forestryapp/screens/diagnosis_form.dart';
import 'package:forestryapp/screens/fire_risk_form.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/components/unsaved_changes.dart';

class OtherIssuesForm extends StatelessWidget {
  static const _title = "Other Issues";
  static const _otherDescription =
      "Describe any other health related issues you observed.";

  const OtherIssuesForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: OtherIssuesForm._title,
        body: FormScaffold(
          prevPage: const FireRiskForm(),
          nextPage: const DiagnosisForm(),
          child: _buildDescription(context),
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    final otherIssuesData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return FreeTextBox(
        labelText: OtherIssuesForm._title,
        helperText: OtherIssuesForm._otherDescription,
        initialValue: otherIssuesData.otherIssues,
        onChanged: (text) {
          otherIssuesData.otherIssues = text;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }
}
