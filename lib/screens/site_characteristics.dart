import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/enums/slope_position.dart";

class SiteCharacteristics extends StatelessWidget {
  // Static Variables
  static const _title = "Site Characteristics";

  const SiteCharacteristics({super.key});

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
  final TextEditingController elevationController = TextEditingController();
  final TextEditingController aspectController = TextEditingController();
  final TextEditingController slopePercentageController =
      TextEditingController();
  return Wrap(spacing: 10.0, runSpacing: 10.0, children: [
    FreeTextBox(
      labelText: 'Elevation',
      controller: elevationController,
      helperText: '',
      onChanged: (text) {
        // Handle elevation text changes
      },
    ),
    FreeTextBox(
      labelText: 'Aspect',
      controller: aspectController,
      helperText: '',
      onChanged: (text) {
        // Handle aspect text changes
      },
    ),
    FreeTextBox(
      labelText: '% Slope',
      controller: slopePercentageController,
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
  final TextEditingController soilInfoController = TextEditingController();
  const historyHelp =
      "Add any information about the soils that is available to you."
      " This can be from either the landowner, or from online.";

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FreeTextBox(
        labelText: 'Soil Information',
        controller: soilInfoController,
        onChanged: (text) {
          // Handle soil information text changes
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
