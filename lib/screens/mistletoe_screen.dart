import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/util/break_points.dart";

class MistletoeScreen extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Mistletoe Infections";
  static const _uniformityHeading = "Uniformity";
  static const _uniformityOptions = ['Uniform throughout stand', 'Spotty'];
  static const _uniformityDescription = 
    "Are the mistletoe infections isolated/grouped, or uniform throughout the area?";
  static const _locationHeading = "Mistletoe location";
  static const _locationDescription = 
    "If the mistletoe infections are spotty, record their locations.";
  static const _hawksworthHeading = "Hawksworth infection rating";
  static const _hawksworthOptions = ['none', 'low', 'medium', 'high'];
  static const _hawksworthDescription = 
    "Rate the mistletoe infection level and check the appropriate rating. If you "
    "are not familiar with this rating system, write your observations elsewhere, "
    "such as under 'Diagnosis & Suggestions.'";
  static const _speciesHeading = "Tree species infected";
  static const _speciesDescription = "List the tree species infected with mistletoe.";
  static const _buttonLabelPrevious = "Previous";
  static const _buttonLabelNext = "Next";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen with a form to add information about mistletoe infections in the area.
  const MistletoeScreen({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Creates a 4x4 grid, but the height matches the content size.
            Wrap(
              children: <Widget>[
                _buildHalfWidthBox(context, _buildUniformityInput(context)),
                _buildHalfWidthBox(context, _buildLocationInput(context)),
                _buildHalfWidthBox(context, _buildHawksworthInput(context)),
                _buildHalfWidthBox(context, _buildSpeciesInput(context)),
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
  /// Wraps another widget to limit its width to 50%, provided device width is
  /// sufficiently large.
  Widget _buildHalfWidthBox(BuildContext context, contents) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FractionallySizedBox(
          widthFactor:
              constraints.maxWidth < BreakPoints.widthPhonePortait ? 1.0 : 0.5,
          child: Padding(padding: const EdgeInsets.all(16.0), child: contents),
        );
      },
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a TextField with a label, helper text, and an outline.
  Widget _buildTextInput(BuildContext context, label, helper) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        helperText: helper,
        border: const OutlineInputBorder(),
      )
    );
  }
  
  /// Builds a radio form field about mistletoe uniformity.
  Widget _buildUniformityInput(BuildContext context) {
    return RadioOptions(
      header: _uniformityHeading, 
      options: _uniformityOptions, 
      onSelected: (i) {},
      helperText: _uniformityDescription,
    );
  }

  /// Builds a radio form field about Hawksworth Infection Rating.
  Widget _buildHawksworthInput(BuildContext context) {
    return RadioOptions(
      header: _hawksworthHeading,
      options: _hawksworthOptions,
      onSelected: (i) {},
      helperText: _hawksworthDescription,
    );
  }

  /// Builds a text input field about mistletoe location.
  Widget _buildLocationInput(BuildContext context) {
    return _buildTextInput(context, _locationHeading, _locationDescription);
  }

  /// Builds a text input field about tree species infected with mistletoe.
  Widget _buildSpeciesInput(BuildContext context) {
    return _buildTextInput(context, _speciesHeading, _speciesDescription);
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