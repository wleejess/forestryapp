import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
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
      body: FormScaffold(
        children: <Widget>[
          _buildSectionTitle(context),
          _buildElevation(context),
          _buildAspect(context),
          _buildPercentSlope(context),
          _buildSlopePosition(context),
          _buildSoilInformation(context)
        ],
      )
    );
  }
}

Widget _buildSectionTitle(BuildContext context) {
  return const PortraitHandlingSizedBox(
    widthFactorOnWideDevices: 1,
    child: Text(
      'General Information',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      )
    ),
  );
}

Widget _buildElevation(BuildContext context) {
  final TextEditingController elevationController = TextEditingController();
  return PortraitHandlingSizedBox(
    widthFactorOnWideDevices: 0.3,
    child: FreeTextBox(
      labelText: 'Elevation',
      controller: elevationController,
      helperText: '',
      onChanged: (text) {
        // Handle elevation text changes
      },
    ),
  );
}

Widget _buildAspect(BuildContext context) {
  final TextEditingController aspectController = TextEditingController();
  return PortraitHandlingSizedBox(
    widthFactorOnWideDevices: 0.3,
    child: FreeTextBox(
      labelText: 'Aspect',
      controller: aspectController,
      helperText: 'Write in the direction the stand or area faces.',
      onChanged: (text) {
        // Handle aspect text changes
      },
    ),
  );
}

Widget _buildPercentSlope(BuildContext context) {
  final TextEditingController slopePercentageController = TextEditingController();
  return PortraitHandlingSizedBox(
    widthFactorOnWideDevices: 0.3,
    child: FreeTextBox(
      labelText: '% Slope',
      controller: slopePercentageController,
      helperText: 'Write in the approximate or average percent slope.',
      onChanged: (text) {},
    ),
  );
}

Widget _buildSlopePosition(BuildContext context) {
  return RadioOptions(
    header: 'Slope Position:',
    enumValues: SlopePosition.values,
    initialValue: SlopePosition.lower,
    onSelected: (selectedOption) {
      // Handle slope position selection
    }
  );
}

Widget _buildSoilInformation(BuildContext context) {
  final TextEditingController soilInfoController = TextEditingController();
  const soilHelp =
      "Add any information about the soils that is available to you."
      " This can be from either the landowner, or from online.";
  
  return FreeTextBox(
    controller: soilInfoController,
    helperText: soilHelp,
    labelText: "Soil Information", 
    onChanged: (text) {
      // Handle soil information text changes
    }
  );
}
