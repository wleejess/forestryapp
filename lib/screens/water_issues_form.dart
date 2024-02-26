import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';

class WaterIssuesForm extends StatelessWidget {
  static const _title = "Water Health & Issues";
  static const _waterDescription =
      "Make note of any issues related to water, streams, and springs in the stand or area.\n"
      "Example: Erosion, head cutting, cattle grazing effects, "
      "sedimentation, culverts, ditches, etc.";

  final _formKey = GlobalKey<FormState>();

  WaterIssuesForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        title: WaterIssuesForm._title,
        body: FormScaffold(
          formKey: _formKey,
          children: <Widget>[_buildDescription(context)],
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    final waterIssuesData = Provider.of<Area>(context);

    return FreeTextBox(
        labelText: WaterIssuesForm._title,
        helperText: WaterIssuesForm._waterDescription,
        initialValue: waterIssuesData.waterHealth,
        onChanged: (text) {
          waterIssuesData.waterHealth = text;
        });
  }
}
