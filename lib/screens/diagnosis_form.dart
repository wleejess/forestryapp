import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:forestryapp/screens/form_review.dart';
import 'package:forestryapp/screens/other_issues_form.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';

class DiagnosisForm extends StatelessWidget {
  static const _title = "Diagnosis & Suggestions";
  static const _diagnosisDescription =
      "Outline or list any issues or problems you see for the stand or area."
      "Provide ideas for action, if needed. Help prioritize what those actions might be."
      "Should the actions occur sooner (now or in the immediate future), or later (next year or beyond)?"
      "Provide a list of resources to refer the landowner to and/or provide other agencies that might help.";

  const DiagnosisForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: DiagnosisForm._title,
        body: FormScaffold(
          prevPage: const OtherIssuesForm(),
          nextPage:
              const FormReview(), // TODO: Send this to the Diagnosis page when implemented
          child: _buildDescription(context),
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    final diagnosisData = Provider.of<Area>(context);

    return FreeTextBox(
        labelText: DiagnosisForm._title,
        helperText: DiagnosisForm._diagnosisDescription,
        initialValue: diagnosisData.diagnosis,
        onChanged: (text) {
          diagnosisData.diagnosis = text;
        });
  }
}
