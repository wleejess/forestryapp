import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/radio_options.dart";

class SiteCharacteristics extends StatelessWidget {
  // Instance Variables
  final TextEditingController _elevationController = TextEditingController();
  final TextEditingController _aspectController = TextEditingController();
  final TextEditingController _slopePercentageController =
      TextEditingController();
  final TextEditingController _soilInfoController = TextEditingController();

  final _title = "Site Characteristics";

  SiteCharacteristics({super.key});

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
              // Elevation, Aspect, % Slope
              Wrap(
                spacing: 16.0, // Add some spacing between the text fields
                runSpacing: 16.0, // Add some spacing between the lines
                children: [
                  FreeTextBox(
                    labelText: 'Elevation',
                    controller: _elevationController,
                    onChanged: (text) {
                      // Handle elevation text changes
                    },
                  ),
                  FreeTextBox(
                    labelText: 'Aspect',
                    controller: _aspectController,
                    onChanged: (text) {
                      // Handle aspect text changes
                    },
                  ),
                  FreeTextBox(
                    labelText: '% Slope',
                    controller: _slopePercentageController,
                    onChanged: (text) {},
                  ),
                ],
              ),

              const SizedBox(height: 16.0),

              // Slope Position
              RadioOptions(
                labelText: 'Slope Position:',
                options: const ['Lower', 'Middle', 'Upper', 'Ridgetop'],
                onSelected: (selectedOption) {
                  // Handle slope position selection
                },
              ),

              const SizedBox(height: 16.0),

              // Soil Information
              FreeTextBox(
                labelText: 'Soil Information',
                controller: _soilInfoController,
                helperText:
                    'Add any information about the soils that is available to you from either the landowner or obtain it online and add this information after your visit.',
                onChanged: (text) {
                  // Handle soil information text changes
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
