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
  final TextEditingController _coverType = TextEditingController();
  final TextEditingController _history = TextEditingController();
  final _title = "Vegetative Conditions";
  static const _coverTitle = "Cover Type";
  static const _composition = "Species Composition";
  static const _compHint = "Enter a % value";
  static const _compTitle = "Stand Structure";
  static const _standDensity = "Stand Density";
  static const _overstoryInfo = "Overstory Stand Info";
  static const _understoryInfo = "Understory Stand Info";
  static const _historyTitle = "Stand/Area History";
  static const _historyHelp =
      "Describe prior management activities and/or disturbances"
      "that have shaped or influenced the stand as it appears today";

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
              DropdownOptions(
                header: _coverTitle,
                enumValues: CoverType.values,
                initialValue: CoverType.forest,
                onSelected: (selectedOption) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FreeTextBox(
                    labelText: "Other",
                    controller: _coverType,
                    helperText: "",
                    onChanged: (text) {
                      // Handle elevation text changes
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Slope Position
              RadioOptions(
                header: _compTitle,
                enumValues: StandStructure.values,
                initialValue: StandStructure.evenAged,
                onSelected: (selectedOption) {
                  // Handle slope position selection
                },
              ),
              const SizedBox(height: 16.0),
              // Overstory Stand Density
              ExpansionTile(
                title: Text(_overstoryInfo),
                collapsedBackgroundColor: Color.fromARGB(255, 46, 96, 69),
                collapsedTextColor: Colors.white,
                collapsedIconColor: Colors.white,
                children: [
                  RadioOptions(
                    header: _standDensity,
                    enumValues: StandDensity.values,
                    initialValue: StandDensity.low,
                    onSelected: (selectedOption) {
                      // Handle overstory stand density selection
                    },
                  ),
                  TextField(
                      decoration: InputDecoration(
                    labelText: _composition,
                    hintText: _compHint,
                  )),
                ],
              ),
              const SizedBox(height: 16.0),
              // Understory Stand Density
              ExpansionTile(
                title: Text(_understoryInfo),
                collapsedBackgroundColor: Color.fromARGB(255, 46, 96, 69),
                collapsedTextColor: Colors.white,
                collapsedIconColor: Colors.white,
                children: [
                  RadioOptions(
                    header: _standDensity,
                    enumValues: StandDensity.values,
                    initialValue: StandDensity.low,
                    onSelected: (selectedOption) {
                      // Handle understory stand density selection
                    },
                  ),
                  TextField(
                      decoration: InputDecoration(
                    labelText: _composition,
                    hintText: _compHint,
                  )),
                ],
              ),
              const SizedBox(height: 16.0),

              FreeTextBox(
                labelText: _historyTitle,
                controller: _history,
                helperText: _historyHelp,
                onChanged: (text) {
                  // Handle elevation text changes
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
