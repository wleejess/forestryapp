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

class VegetativeConditionsForm extends StatelessWidget {
  // Instance Variables
  final _title = "Vegetative Conditions";
  static const _coverTitle = "Cover Type";
  static const _strucTitle = "Stand Structure";
  static const _standDensity = "Stand Density";
  static const _overstoryInfo = "Overstory Stand Info";
  static const _understoryInfo = "Understory Stand Info";

  final _formKey = GlobalKey<FormState>();

  VegetativeConditionsForm({super.key});

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
          initialValue: title == 'Overstory Stand Info'
              ? vegConData.overstoryDensity
              : vegConData.understoryDensity,
          onSelected: (selectedOption) {
            title == 'Overstory Stand Info'
                ? vegConData.overstoryDensity = selectedOption
                : vegConData.understoryDensity = selectedOption;
            unsavedChangesNotifier.setUnsavedChanges(true);
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: "Species Composition", hintText: "Enter a % value"),
          initialValue: title == 'Overstory Stand Info'
              ? vegConData.overstorySpeciesComposition?.toString()
              : vegConData.understorySpeciesComposition?.toString(),
          keyboardType: TextInputType.number,
          validator: Validation.isValidPercentage,
          onChanged: (text) {
            title == 'Overstory Stand Info'
                ? vegConData.overstorySpeciesComposition = int.tryParse(text)
                : vegConData.understorySpeciesComposition = int.tryParse(text);
            unsavedChangesNotifier.setUnsavedChanges(true);
          },
        ),
      ],
    );
  }

  Widget _buildStandHistory(BuildContext context) {
    final vegConData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    const historyTitle = "Stand/Area History";
    const historyHelp =
        "Describe prior management activities and/or disturbances"
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
