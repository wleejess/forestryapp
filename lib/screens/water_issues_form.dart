import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:forestryapp/screens/fire_risk_form.dart';
import 'package:forestryapp/screens/road_health_form.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/components/unsaved_changes.dart';

/// Represents a form for capturing water health and issues in the area.
///
/// This form allows users to input information about various water-related issues
/// such as erosion, sedimentation, culverts, ditches, etc.
class WaterIssuesForm extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _title = "Water Health & Issues";
  static const _waterDescription =
      "Make note of any issues related to water, streams, and springs in the stand or area.\n"
      "Example: Erosion, head cutting, cattle grazing effects, "
      "sedimentation, culverts, ditches, etc.";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen for capturing water health and issues.
  const WaterIssuesForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: WaterIssuesForm._title,
        body: FormScaffold(
          prevPage: const RoadHealthForm(),
          nextPage: const FireRiskForm(),
          child: _buildDescription(context),
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a text input field to enter water health and issues information.
  Widget _buildDescription(BuildContext context) {
    final waterIssuesData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return FreeTextBox(
        labelText: WaterIssuesForm._title,
        helperText: WaterIssuesForm._waterDescription,
        initialValue: waterIssuesData.waterHealth,
        onChanged: (text) {
          waterIssuesData.waterHealth = text;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }
}
