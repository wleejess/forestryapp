import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/enums/hawksworth.dart";
import "package:forestryapp/enums/mistletoe_uniformity.dart";

class MistletoeScreen extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Mistletoe Infections";
  static const _uniformityHeading = "Uniformity";
  static const _uniformityDescription =
    "Are the mistletoe infections isolated/grouped, or uniform throughout the area?";
  static const _locationHeading = "Mistletoe location";
  static const _locationDescription = 
    "If the mistletoe infections are spotty, record their locations.";
  static const _hawksworthHeading = "Hawksworth infection rating";
  static const _hawksworthDescription =
    "Rate the mistletoe infection level and check the appropriate rating. If you "
    "are not familiar with this rating system, write your observations elsewhere, "
    "such as under 'Diagnosis & Suggestions.'";
  static const _speciesHeading = "Tree species infected";
  static const _speciesDescription = "List the tree species infected with mistletoe.";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen with a form to add information about mistletoe infections in the area.
  const MistletoeScreen({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      PortraitHandlingSizedBox(child: _buildUniformityInput(context)),
      PortraitHandlingSizedBox(child: _buildLocationInput(context)),
      PortraitHandlingSizedBox(child: _buildHawksworthInput(context)),
      PortraitHandlingSizedBox(child: _buildSpeciesInput(context))
    ];

    return ForestryScaffold(
      title: _title,
      body: FormScaffold(
        children: children,
      )
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a radio form field about mistletoe uniformity.
  Widget _buildUniformityInput(BuildContext context) {
    return RadioOptions(
      header: _uniformityHeading,
      enumValues: MistletoeUniformity.values,
      initialValue: MistletoeUniformity.uniform,
      onSelected: (i) {},
      helperText: _uniformityDescription,
    );
  }

  /// Builds a radio form field about Hawksworth Infection Rating.
  Widget _buildHawksworthInput(BuildContext context) {
    return RadioOptions(
      header: _hawksworthHeading,
      enumValues: Hawksworth.values,
      initialValue: Hawksworth.none,
      onSelected: (i) {},
      helperText: _hawksworthDescription,
    );
  }

  /// Builds a text input field about mistletoe location.
  Widget _buildLocationInput(BuildContext context) {
    final TextEditingController locationController = TextEditingController();

    return FreeTextBox(
      controller: locationController, 
      labelText: _locationHeading, 
      helperText: _locationDescription,
      onChanged: (text) {}
    );
  }

  /// Builds a text input field about tree species infected with mistletoe.
  Widget _buildSpeciesInput(BuildContext context) {
    final TextEditingController speciesController = TextEditingController();

    return FreeTextBox(
      controller: speciesController, 
      labelText: _speciesHeading, 
      helperText: _speciesDescription,
      onChanged: (text) {}
    );
  }
}
