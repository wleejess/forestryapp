import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/components/dropdown.dart";
import "package:forestryapp/enums/stand_density.dart";
import "package:forestryapp/enums/stand_structure.dart";
import "package:forestryapp/enums/cover_type.dart";

class VegetativeConditions extends StatelessWidget {
  // Instance Variables
  final _title = "Vegetative Conditions";
  static const _coverTitle = "Cover Type";
  static const _strucTitle = "Stand Structure";
  static const _standDensity = "Stand Density";
  static const _overstoryInfo = "Overstory Stand Info";
  static const _understoryInfo = "Understory Stand Info";

  VegetativeConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
      ),
    );
  }
}

Widget _buildCoverType(BuildContext context, header) {
  final TextEditingController _coverType = TextEditingController();

  return Wrap(
    spacing: 20.0,
    runSpacing: 20.0,
    children: [
      DropdownOptions(
        header: header,
        enumValues: CoverType.values,
        initialValue: CoverType.forest,
        onSelected: (selectedOption) {},
      ),
      FreeTextBox(
        labelText: "Other Cover Type",
        controller: _coverType,
        helperText: "List cover type if the option is not in the dropdown.",
        onChanged: (text) {
          // Handle elevation text changes
        },
      ),
    ],
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
  final TextEditingController history = TextEditingController();
  const historyTitle = "Stand/Area History";
  const historyHelp = "Describe prior management activities and/or disturbances"
      "that have shaped or influenced the stand as it appears today";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FreeTextBox(
        labelText: historyTitle,
        controller: history,
        onChanged: (text) {
          // Handle elevation text changes
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
