import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:forestryapp/screens/other_issues_form.dart';
import 'package:forestryapp/screens/water_issues_form.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/components/unsaved_changes.dart';

/// Represents a form for assessing fire risk within a forestry context.
///
/// This form enables users to note the level of fuel on the ground (high, medium, low),
/// assess the density and structure of the forest, and evaluate factors such as the presence
/// of ladder fuels and the potential for ignition. It includes a description field for entering
/// observations and assessments related to fire risk, along with options to navigate to other
/// form pages.
class FireRiskForm extends StatelessWidget {
  static const _title = "Fire Risk";
  static const _fireDescription =
      "Note the level of fuel on the ground (high, medium, low), "
      "as well as the density and structure of the forest.\n"
      "Are there abundant ladder fuels? What is the potential for ignition?";

  // Constructor ////////////////////////////////////////////////////////////////
  /// Constructs a FireRiskForm widget.
  ///
  /// Key is an optional parameter used to identify the widget.
  const FireRiskForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: FireRiskForm._title,
        body: FormScaffold(
          prevPage: const WaterIssuesForm(),
          nextPage: const OtherIssuesForm(),
          child: _buildDescription(context),
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds the description input field for assessing fire risk.
  ///
  /// Retrieves fire risk data from the provider and initializes the FreeTextBox widget
  /// with appropriate labels, description, initial value, and onChanged callback.
  /// Also updates the unsaved changes notifier when changes are made.
  Widget _buildDescription(BuildContext context) {
    final fireRiskData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return FreeTextBox(
        labelText: FireRiskForm._title,
        helperText: FireRiskForm._fireDescription,
        initialValue: fireRiskData.fireRisk,
        onChanged: (text) {
          fireRiskData.fireRisk = text;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }
}
