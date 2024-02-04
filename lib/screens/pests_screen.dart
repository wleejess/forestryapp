import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

class PestsScreen extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Pests & Damages A";
  static const _insectsHeading = "Insects present";
  static const _insectsDescription = 
    "If past or present insect damage is apparent in the stand or area, "
    "list the insects observed, if known.";
  static const _diseasesHeading = "Diseases present";
  static const _diseasesDescription = 
    "If past or present disease damage is apparent in the stand or area, "
    "list diseases observed, if known.";
  static const _buttonLabelPrevious = "Previous";
  static const _buttonLabelNext = "Next";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to enter information on insects and diseases present in the area.
  const PestsScreen({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Wrap(
              children: <Widget>[
                _buildInsectsInput(context),
                _buildDiseasesInput(context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonPrevious(context),
                _buildButtonNext(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Layout ////////////////////////////////////////////////////////////////////

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildTextInput(BuildContext context, label, helper) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        helperText: helper,
        border: const OutlineInputBorder(),
      )
    );
  }

  Widget _buildInsectsInput(BuildContext context) {
    return _buildTextInput(context, _insectsHeading, _insectsDescription);
  }

  Widget _buildDiseasesInput(BuildContext context) {
    return _buildTextInput(context, _diseasesHeading, _diseasesDescription);
  }

  // Buttons ///////////////////////////////////////////////////////////////////
  Widget _buildButtonPrevious(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonLabelPrevious),
    );
  }

  Widget _buildButtonNext(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonLabelNext),
    );
  }
}