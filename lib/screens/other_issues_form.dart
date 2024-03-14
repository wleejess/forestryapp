import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:forestryapp/screens/diagnosis_form.dart';
import 'package:forestryapp/screens/fire_risk_form.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/components/unsaved_changes.dart';

/// Represents a form for capturing information about other health-related issues observed in the area.
///
/// This form allows users to describe any other health-related issues they observed in the stand or area.
/// It includes a text input field for providing details, along with a description for guidance.
class OtherIssuesForm extends StatelessWidget {
  static const _title = "Other Issues";
  static const _otherDescription =
      "Describe any other health related issues you observed.";

  // Constructor ////////////////////////////////////////////////////////////////
  /// Creates a screen to enter information about other health-related issues.
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
  /// Builds a text input field to enter details about other health-related issues observed in the area.
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
