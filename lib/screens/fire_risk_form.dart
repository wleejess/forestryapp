import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';

class FireRiskForm extends StatelessWidget {
  static const _title = "Fire Risk";
  static const _fireDescription =
      "Note the level of fuel on the ground (high, medium, low), "
      "as well as the density and structure of the forest.\n"
      "Are there abundant ladder fuels? What is the potential for ignition?";

  final _formKey = GlobalKey<FormState>();

  FireRiskForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        title: FireRiskForm._title,
        body: FormScaffold(
          formKey: _formKey,
          children: <Widget>[_buildDescription(context)],
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    final fireRiskData = Provider.of<Area>(context);

    return FreeTextBox(
        labelText: FireRiskForm._title,
        helperText: FireRiskForm._fireDescription,
        initialValue: fireRiskData.fireRisk,
        onChanged: (text) {
          fireRiskData.fireRisk = text;
        });
  }
}
