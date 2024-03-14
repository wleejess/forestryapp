import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:forestryapp/screens/form_review.dart';
import 'package:forestryapp/screens/other_issues_form.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';

/// Represents a form for diagnosing issues and providing suggestions within a forestry context.
///
/// This form allows users to outline any issues observed in a forest stand or area and
/// provide suggestions for actions, if needed. It includes a description field for entering
/// diagnoses and suggestions, along with options to navigate to other form pages and review
/// the form contents.
class DiagnosisForm extends StatelessWidget {
  static const _title = "Diagnosis & Suggestions";
  static const _diagnosisDescription =
      "Outline any issues you see for the stand or area. "
      "Provide ideas for action, if needed.\n"
      "Help prioritize the actions: Should they occur sooner or later?";

  // Constructor ////////////////////////////////////////////////////////////////
  /// Constructs a DiagnosisForm widget.
  ///
  /// Key is an optional parameter used to identify the widget.
  const DiagnosisForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: DiagnosisForm._title,
        body: FormScaffold(
          prevPage: const OtherIssuesForm(),
          nextPage: const FormReview(),
          child: _buildDescription(context),
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds the description input field for diagnosing issues and providing suggestions.
  ///
  /// Retrieves diagnosis data from the provider and initializes the FreeTextBox widget
  /// with appropriate labels, description, initial value, and onChanged callback.
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
