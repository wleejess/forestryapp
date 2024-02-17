import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/road_health.dart';

class RoadHealthForm extends StatelessWidget {
  static const _title = "Road Health";
  static const _roadDescription =
      "Make note of any road related problems for the stand or area.\n"
      "Example: Erosion, slumps, sediment delviery into streams or other waterways, "
      "culvert & ditch problems, etc";

  final _formKey = GlobalKey<FormState>();

  RoadHealthForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        title: RoadHealthForm._title,
        body: FormScaffold(
          formKey: _formKey,
          children: <Widget>[_buildDescription(context)],
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    final roadHealthData = Provider.of<RoadHealth>(context);
    return FreeTextBox(
        labelText: RoadHealthForm._title,
        helperText: RoadHealthForm._roadDescription,
        onChanged: (text) {
          roadHealthData.roadInfo;
        });
  }
}