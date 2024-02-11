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

class VegetativeConditions extends StatefulWidget {
  // Instance Variables
  static const _title = "Vegetative Conditions";
  static const _coverTitle = "Cover Type";
  static const _strucTitle = "Stand Structure";
  static const _standDensity = "Stand Density";
  static const _overstoryInfo = "Overstory Stand Info";
  static const _understoryInfo = "Understory Stand Info";

  const VegetativeConditions({super.key});

  @override
  State<VegetativeConditions> createState() => _VegetativeConditionsState();
}

class _VegetativeConditionsState extends State<VegetativeConditions> {
  // State /////////////////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _coverTypeController;
  late final TextEditingController _standHistoryController;

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    _coverTypeController = TextEditingController();
    _standHistoryController = TextEditingController();
  }

  @override
  void dispose() {
    _coverTypeController.dispose();
    _standHistoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: VegetativeConditions._title,
      body: FormScaffold(
        formKey: _formKey,
        children: <Widget>[
          // Cover Type
          _buildCoverType(context, VegetativeConditions._coverTitle),
          _buildOtherCoverType(context),
          _buildStandStructure(context, VegetativeConditions._strucTitle),
          // Overstory Stand Density
          _buildStoryInfo(context, VegetativeConditions._overstoryInfo, VegetativeConditions._standDensity),
          const SizedBox(height: 16.0),
          _buildStoryInfo(context, VegetativeConditions._understoryInfo, VegetativeConditions._standDensity),
          _buildStandHistory(context)
        ],
      )
    );
  }

  Widget _buildCoverType(BuildContext context, header) {
    return PortraitHandlingSizedBox(
      child: DropdownOptions(
        header: header,
        enumValues: CoverType.values,
        initialValue: CoverType.forest,
        onSelected: (selectedOption) {},
      ),
    );
  }

  Widget _buildOtherCoverType(BuildContext context) {
    return PortraitHandlingSizedBox(
      child: FreeTextBox(
        labelText: "Other Cover Type",
        controller: _coverTypeController,
        helperText: "List cover type if the option is not in the dropdown.",
        onChanged: (text) {
          // Handle elevation text changes
        },
      )
    );
  }

  Widget _buildStandStructure(BuildContext context, header) {
    return RadioOptions(
      header: header,
      enumValues: StandStructure.values,
      initialValue: StandStructure.evenAged,
      onSelected: (selectedOption) {
        // Handle slope position selection
      },
    );
  }

  Widget _buildStoryInfo(BuildContext context, title, density) {
    return ExpansionTile(
      title: Text(title),
      collapsedBackgroundColor: const Color.fromARGB(255, 46, 96, 69),
      collapsedTextColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: [
        RadioOptions(
          header: density,
          enumValues: StandDensity.values,
          initialValue: StandDensity.low,
          onSelected: (selectedOption) {
            // Handle overstory stand density selection
          },
        ),
        const TextField(
            decoration: InputDecoration(
          labelText: "Species Composition",
          hintText: "Enter a % value",
        )),
      ],
    );
  }

  Widget _buildStandHistory(BuildContext context) {
    const historyTitle = "Stand/Area History";
    const historyHelp = "Describe prior management activities and/or disturbances"
        "that have shaped or influenced the stand as it appears today";
    return FreeTextBox(
      labelText: historyTitle,
      helperText: historyHelp,
      controller: _standHistoryController,
      onChanged: (text) {
        // Handle elevation text changes
      },
    );
  }
}