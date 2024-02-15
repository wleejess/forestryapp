import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';

class FireRisk extends StatelessWidget {
  static const _title = "Fire Risk";
  static const _fireDescription =
      "Note the level of fuel on the ground (high, medium, low), "
      "as well as the density and structure of the forest.\n"
      "Are there abundant ladder fuels? What is the potential for ignition?";

  final _formKey = GlobalKey<FormState>();

  FireRisk({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: FireRisk._title,
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
      labelText: FireRisk._title,
      helperText: FireRisk._fireDescription,
      onChanged: (text) {}
    );
  }
}
