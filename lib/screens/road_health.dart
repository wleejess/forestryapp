import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';

class RoadHealth extends StatelessWidget {
  final TextEditingController _roadController = TextEditingController();
  static const _title = "Road Health";
  static const _roadDescription =
      "Make note of any road related problems for the stand or area.\n"
      "Example: Erosion, slumps, sediment delviery into streams or other waterways, "
      "culvert & ditch problems, etc";

  RoadHealth({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: FormScaffold(
        children: <Widget>[
          _buildDescription(context)
        ],
      )
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    return FreeTextBox(
      controller: _roadController, 
      labelText: _title,
      helperText: _roadDescription,
      onChanged: (text) {}
    );
  }
}
