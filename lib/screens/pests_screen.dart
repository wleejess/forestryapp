import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";

class PestsScreen extends StatelessWidget {
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

  final _formKey = GlobalKey<FormState>();

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to enter information on insects and diseases present in the area.
  PestsScreen({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: PestsScreen._title,
      body: FormScaffold(
        formKey: _formKey,
        children: <Widget>[
          _buildInsectsInput(context),
          _buildDiseasesInput(context)          
        ],
      )
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildInsectsInput(BuildContext context) {
    return FreeTextBox(
      labelText: PestsScreen._insectsHeading, 
      helperText: PestsScreen._insectsDescription,
      onChanged: (text) {}
    );
  }

  Widget _buildDiseasesInput(BuildContext context) {
    return FreeTextBox(
      labelText: PestsScreen._diseasesHeading, 
      helperText: PestsScreen._diseasesDescription,
      onChanged: (text) {}
    );
  }
}
