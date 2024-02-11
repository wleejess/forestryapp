import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';

class RoadHealth extends StatefulWidget {
  static const _title = "Road Health";
  static const _roadDescription =
      "Make note of any road related problems for the stand or area.\n"
      "Example: Erosion, slumps, sediment delviery into streams or other waterways, "
      "culvert & ditch problems, etc";

  const RoadHealth({super.key});

  @override
  State<RoadHealth> createState() => _RoadHealthState();
}

class _RoadHealthState extends State<RoadHealth> {
  // State /////////////////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _roadController;

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    _roadController = TextEditingController();
  }

  @override
  void dispose() {
    _roadController.dispose();

    super.dispose();
  }

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: RoadHealth._title,
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
      controller: _roadController, 
      labelText: RoadHealth._title,
      helperText: RoadHealth._roadDescription,
      onChanged: (text) {}
    );
  }
}
