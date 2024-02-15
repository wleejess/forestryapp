import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';

class WaterIssues extends StatelessWidget {
  static const _title = "Water Health & Issues";
  static const _waterDescription =
      "Make note of any issues related to water, streams, and springs in the stand or area.\n"
      "Example: Erosion, head cutting, cattle grazing effects, "
      "sedimentation, culverts, ditches, etc.";

  final _formKey = GlobalKey<FormState>();

  WaterIssues({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: WaterIssues._title,
      body: FormScaffold(
        formKey: _formKey,
        children: <Widget>[
          _buildDescription(context)
        ],
      )
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    return FreeTextBox(
      labelText: WaterIssues._title,
      helperText: WaterIssues._waterDescription,
      onChanged: (text) {}
    );
  }
}
