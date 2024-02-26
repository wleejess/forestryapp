import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/models/area.dart";
import "package:provider/provider.dart";

class InsectsForm extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Insects & Diseases";
  static const _insectsHeading = "Insects present";
  static const _insectsDescription =
      "If past or present insect damage is apparent in the stand or area, "
      "list the insects observed, if known.";
  static const _diseasesHeading = "Diseases present";
  static const _diseasesDescription =
      "If past or present disease damage is apparent in the stand or area, "
      "list diseases observed, if known.";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to enter information on insects and diseases present in the area.
  const InsectsForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        title: InsectsForm._title,
        body: FormScaffold(
          child: Column(
            children: <Widget>[
              _buildInsectsInput(context),
              _buildDiseasesInput(context)
            ],
          )
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildInsectsInput(BuildContext context) {
    final insectsData = Provider.of<Area>(context);
    return FreeTextBox(
        labelText: InsectsForm._insectsHeading,
        helperText: InsectsForm._insectsDescription,
        initialValue: insectsData.insects,
        onChanged: (text) {
          insectsData.insects = text;
        });
  }

  Widget _buildDiseasesInput(BuildContext context) {
    final insectsData = Provider.of<Area>(context);
    return FreeTextBox(
        labelText: InsectsForm._diseasesHeading,
        helperText: InsectsForm._diseasesDescription,
        initialValue: insectsData.diseases,
        onChanged: (text) {
          insectsData.diseases = text;
        });
  }
}
