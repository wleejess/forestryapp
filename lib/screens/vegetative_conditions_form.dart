import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/components/dropdown.dart";
import "package:forestryapp/enums/stand_density.dart";
import "package:forestryapp/enums/stand_structure.dart";
import "package:forestryapp/enums/cover_type.dart";
import "package:forestryapp/screens/insects_form.dart";
import "package:forestryapp/screens/site_characteristics_form.dart";
import "package:forestryapp/util/validation.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/components/unsaved_changes.dart';

/// Represents a form for capturing vegetative conditions of the area.
///
/// This form allows users to input information about cover type, stand structure,
/// overstory and understory stand densities, species composition, and stand history.
class VegetativeConditionsForm extends StatelessWidget {
  // Instance Variables
  final _title = "Vegetative Conditions";
  static const _coverTitle = "Cover Type";
  static const _strucTitle = "Stand Structure";
  static const _standDensity = "Stand Density";
  static const _overstoryInfo = "Overstory Stand Info";
  static const _understoryInfo = "Understory Stand Info";

  final _formKey = GlobalKey<FormState>();

  // Constructor ////////////////////////////////////////////////////////////////
  /// Creates a screen for capturing vegetative conditions.
  VegetativeConditionsForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: _title,
        body: FormScaffold(
          prevPage: SiteCharacteristicsForm(),
          nextPage: const InsectsForm(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cover Type
                _buildCoverType(context, _coverTitle),
                _buildStandStructure(context, _strucTitle),
                // Overstory Stand Density
                _buildStoryInfo(context, _overstoryInfo, _standDensity),
                const SizedBox(height: 16.0),
                _buildStoryInfo(context, _understoryInfo, _standDensity),
                _buildStandHistory(context)
              ],
            ),
          ),
        ));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds widgets to select cover type and other cover type details.
  Widget _buildCoverType(BuildContext context, header) {
    final vegConData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return Wrap(
      children: [
        PortraitHandlingSizedBox(
          child: DropdownOptions(
            header: header,
            enumValues: CoverType.values,
            initialValue: vegConData.coverType,
            onSelected: (selectedOption) {
              vegConData.coverType = selectedOption;
              unsavedChangesNotifier.setUnsavedChanges(true);
            },
          ),
        ),
        PortraitHandlingSizedBox(
          child: FreeTextBox(
            labelText: "Other Cover Type",
            helperText: "List cover type if the option is not in the dropdown.",
            onChanged: (text) {},
          ),
        ),
      ],
    );
  }

  /// Builds radio options to select the stand structure of the area.
  Widget _buildStandStructure(BuildContext context, header) {
    final vegConData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return RadioOptions(
      header: header,
      enumValues: StandStructure.values,
      initialValue: vegConData.standStructure,
      onSelected: (selectedOption) {
        vegConData.standStructure = selectedOption;
        unsavedChangesNotifier.setUnsavedChanges(true);
      },
    );
  }

  /// Builds expansion tiles to input stand density and species composition details.
  Widget _buildStoryInfo(BuildContext context, title, density) {
    final vegConData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return ExpansionTile(
      title: Text(title),
      collapsedBackgroundColor: const Color.fromARGB(255, 46, 96, 69),
      collapsedTextColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: [
        RadioOptions(
          header: density,
          enumValues: StandDensity.values,
          initialValue: title == _overstoryInfo
              ? vegConData.overstoryDensity
              : vegConData.understoryDensity,
          onSelected: (selectedOption) {
            title == _overstoryInfo
                ? vegConData.overstoryDensity = selectedOption
                : vegConData.understoryDensity = selectedOption;
            unsavedChangesNotifier.setUnsavedChanges(true);
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: "Species Composition", hintText: "Enter a % value"),
          initialValue: title == _overstoryInfo
              ? vegConData.overstorySpeciesComposition?.toString()
              : vegConData.understorySpeciesComposition?.toString(),
          keyboardType: TextInputType.number,
          validator: Validation.isValidPercentage,
          onChanged: (text) {
            if (!_formKey.currentState!.validate()) return;

            title == _overstoryInfo
                ? vegConData.overstorySpeciesComposition = int.tryParse(text)
                : vegConData.understorySpeciesComposition = int.tryParse(text);
            unsavedChangesNotifier.setUnsavedChanges(true);
          },
        ),
      ],
    );
  }

  /// Builds a text input field to enter stand history information.
  Widget _buildStandHistory(BuildContext context) {
    final vegConData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    const historyTitle = "Stand/Area History";
    const historyHelp =
        "Describe prior management activities and/or disturbances "
        "that have shaped or influenced the stand as it appears today";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FreeTextBox(
          labelText: historyTitle,
          initialValue: vegConData.standHistory,
          onChanged: (text) {
            vegConData.standHistory = text;
            unsavedChangesNotifier.setUnsavedChanges(true);
          },
        ),
        const SizedBox(height: 16.0),
        const Text(
          historyHelp,
          style: TextStyle(
              fontSize: 14.0,
              fontStyle: FontStyle.italic), // Customize the font size as needed
        )
      ],
    );
  }
}
