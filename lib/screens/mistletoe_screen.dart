import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/radio_options.dart";

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
  /// Creates a screen to enter information on mistletoe infections.
  const MistletoeScreen({super.key});

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
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: RadioOptions(
                    header: _uniformityHeading, 
                    options: _uniformityOptions, 
                    onSelected: (i) {},
                  ),
                ),
                _buildLocationInput(context),
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: RadioOptions(
                    header: _hawksworthHeading,
                    options: _hawksworthOptions,
                    onSelected: (i) {},
                  ),
                ),
                _buildSpeciesInput(context),
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

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildLocationInput(BuildContext context) {
    return const FractionallySizedBox(
      widthFactor: 0.5,
      child: TextField(
        decoration: InputDecoration(
          labelText: _locationHeading,
          helperText: _locationDescription,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildSpeciesInput(BuildContext context) {
    return const FractionallySizedBox(
      widthFactor: 0.5,
      child: TextField(
        decoration: InputDecoration(
          labelText: _speciesHeading,
          helperText: _speciesDescription,
          border: OutlineInputBorder(),
        ),
      ),
    );
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