import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";

class InvasiveScreen extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Invasive & Wildlife";
  static const _invasiveHeading = "Invasive plants & animals";
  static const _invasiveDescription = "List any invasive plants or animals observed.";
  static const _wildlifeHeading = "Wildlife damage/issues";
  static const _wildlifeDescription = "Describe wildlife damage to tree seedlings, "
    "saplings or mature trees.\nIf regeneration is damaged, estimate the percentage "
    "of seedlings/saplings affected.";

  final _formKey = GlobalKey<FormState>();

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to enter information on invasive plants and animals,
  /// and wildlife damage present in the area.
  InvasiveScreen({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: InvasiveScreen._title,
      body: FormScaffold(
        formKey: _formKey,
        children: <Widget>[
          _buildInvasiveInput(context),
          _buildWildlifeInput(context),
        ],
      )
    );
  }

  /// Builds a text input field about invasive plants and animals in the area.
  Widget _buildInvasiveInput(BuildContext context) {
    return FreeTextBox(
      labelText: InvasiveScreen._invasiveHeading, 
      helperText: InvasiveScreen._invasiveDescription,
      onChanged: (text) {}
    );
  }

  /// Builds a text input field about wildlife damage in the area.
  Widget _buildWildlifeInput(BuildContext context) {
    return FreeTextBox(
      labelText: InvasiveScreen._wildlifeHeading, 
      helperText: InvasiveScreen._wildlifeDescription,
      onChanged: (text) {}
    );
  }
}