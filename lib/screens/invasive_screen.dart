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

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to enter information on invasive plants and animals,
  /// and wildlife damage present in the area.
  const InvasiveScreen({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: FormScaffold(
        children: <Widget>[
          _buildInvasiveInput(context),
          _buildWildlifeInput(context),
        ],
      )
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a text input field about invasive plants and animals in the area.
  Widget _buildInvasiveInput(BuildContext context) {
    final TextEditingController invasiveController = TextEditingController();
    return FreeTextBox(
      controller: invasiveController, 
      labelText: _invasiveHeading, 
      helperText: _invasiveDescription,
      onChanged: (text) {}
    );
  }

  /// Builds a text input field about wildlife damage in the area.
  Widget _buildWildlifeInput(BuildContext context) {
    final TextEditingController wildlifeController = TextEditingController();
    return FreeTextBox(
      controller: wildlifeController, 
      labelText: _wildlifeHeading, 
      helperText: _wildlifeDescription,
      onChanged: (text) {}
    );
  }
}