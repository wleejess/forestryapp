import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:forestryapp/screens/mistletoe_form.dart';
import 'package:forestryapp/screens/water_issues_form.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/components/unsaved_changes.dart';

/// Represents a form for capturing information about road-related issues in the area.
///
/// This form allows users to note any road-related problems they observe in the stand or area.
/// It includes a text input field for providing details, along with a description for guidance.
class RoadHealthForm extends StatelessWidget {
  static const _title = "Road Health";
  static const _roadDescription =
      "Make note of any road related problems for the stand or area.\n"
      "Example: Erosion, slumps, sediment delivery into streams or other waterways, "
      "culvert & ditch problems, etc";

  // Constructor ////////////////////////////////////////////////////////////////
  /// Creates a screen to enter information about road-related issues.
  const RoadHealthForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: RoadHealthForm._title,
        body: FormScaffold(
          prevPage: const MistletoeForm(),
          nextPage: const WaterIssuesForm(),
          child: _buildDescription(context),
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a text input field to enter details about road-related issues observed in the area.
  Widget _buildDescription(BuildContext context) {
    final roadHealthData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return FreeTextBox(
        labelText: RoadHealthForm._title,
        helperText: RoadHealthForm._roadDescription,
        initialValue: roadHealthData.roadHealth,
        onChanged: (text) {
          roadHealthData.roadHealth = text;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }
}
