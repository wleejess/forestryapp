import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/enums/slope_position.dart";

class SiteCharacteristics extends StatelessWidget {
  // Static Variables
  static const _title = "Site Characteristics";

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
              // Title
              const Text(
                'General Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _buildElevationAspectSlope(context),
              _buildSlopePosition(context),
              _buildSoilInformation(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildElevationAspectSlope(BuildContext context) {
  final TextEditingController _elevationController = TextEditingController();
  final TextEditingController _aspectController = TextEditingController();
  final TextEditingController _slopePercentageController =
      TextEditingController();
  return Wrap(spacing: 10.0, runSpacing: 10.0, children: [
    FreeTextBox(
      labelText: 'Elevation',
      controller: _elevationController,
      helperText: '',
      onChanged: (text) {
        // Handle elevation text changes
      },
    ),
    FreeTextBox(
      labelText: 'Aspect',
      controller: _aspectController,
      helperText: '',
      onChanged: (text) {
        // Handle aspect text changes
      },
    ),
    FreeTextBox(
      labelText: '% Slope',
      controller: _slopePercentageController,
      helperText: '',
      onChanged: (text) {},
    ),
    const SizedBox(height: 16.0)
  ]);
}

Widget _buildSlopePosition(BuildContext context) {
  return RadioOptions(
    header: 'Slope Position:',
    enumValues: SlopePosition.values,
    initialValue: SlopePosition.lower,
    onSelected: (selectedOption) {
      // Handle slope position selection
    },
  );
}

Widget _buildSoilInformation(BuildContext context) {
  final TextEditingController _soilInfoController = TextEditingController();
  return FreeTextBox(
    labelText: 'Soil Information',
    controller: _soilInfoController,
    helperText:
        'Add any information about the soils that is available to you from either the landowner or obtain it online and add this information after your visit.',
    onChanged: (text) {
      // Handle soil information text changes
    },
  );
}
