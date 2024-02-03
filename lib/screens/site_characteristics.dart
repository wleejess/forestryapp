import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/enums/slope_position.dart";

class SiteCharacteristics extends StatelessWidget {
  // Instance Variables
  final TextEditingController _elevationController = TextEditingController();
  final TextEditingController _aspectController = TextEditingController();
  final TextEditingController _slopePercentageController =
      TextEditingController();
  final TextEditingController _soilInfoController = TextEditingController();

  final _title = "Forest Wellness Checkup";

  SiteCharacteristics({super.key});

  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            const Text('Site Characteristics'),

            // Elevation, Aspect, % Slope
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FreeTextBox(
                  header: 'Elevation',
                  controller: _elevationController,
                  hintText: '',
                  onChanged: (text) {
                    // Handle elevation text changes
                  },
                ),
                FreeTextBox(
                  header: 'Aspect',
                  controller: _aspectController,
                  hintText: '',
                  onChanged: (text) {
                    // Handle aspect text changes
                  },
                ),
                FreeTextBox(
                  header: '% Slope',
                  controller: _slopePercentageController,
                  hintText: '',
                  onChanged: (text) {},
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Slope Position
            RadioOptions(
              header: 'Slope Position:',
              enumValues: SlopePosition.values,
              initialValue: SlopePosition.lower,
              onSelected: (selectedOption) {
                // Handle slope position selection
              },
            ),

            const SizedBox(height: 16.0),

            // Soil Information
            FreeTextBox(
              header: 'Soil Information',
              controller: _soilInfoController,
              hintText:
                  'Add any information about the soils that is available to you from either the landowner or obtain it online and add this information after your visit.',
              onChanged: (text) {
                // Handle soil information text changes
              },
            ),
          ],
        ),
      ),
    );
  }
}
