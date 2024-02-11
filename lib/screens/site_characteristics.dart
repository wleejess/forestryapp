import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/components/dropdown.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/enums/slope_position.dart";
import "package:forestryapp/enums/direction.dart";

class SiteCharacteristics extends StatefulWidget {
  // Static Variables
  static const _title = "Site Characteristics";

  const SiteCharacteristics({super.key});

  @override
  State<SiteCharacteristics> createState() => _SiteCharacteristicsState();
}

class _SiteCharacteristicsState extends State<SiteCharacteristics> {
  // State /////////////////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _elevationController;
  late final TextEditingController _slopePercentageController;
  late final TextEditingController _soilInfoController;

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    _elevationController = TextEditingController();
    _slopePercentageController = TextEditingController();
    _soilInfoController = TextEditingController();
  }

  @override
  void dispose() {
    _elevationController.dispose();
    _slopePercentageController.dispose();
    _soilInfoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ForestryScaffold(
      title: SiteCharacteristics._title,
      body: FormScaffold(
        formKey: _formKey,
        children: <Widget>[
          _buildAspect(context),
          _buildElevation(context),
          _buildPercentSlope(context),
          _buildSlopePosition(context),
          _buildSoilInformation(context)
        ],
      )
    );
  }

  Widget _buildElevation(BuildContext context) {
    return PortraitHandlingSizedBox(
      widthFactorOnWideDevices: 0.3,
      child: FreeTextBox(
        labelText: 'Elevation',
        controller: _elevationController,
        helperText: '',
        onChanged: (text) {
          // Handle elevation text changes
        },
      ),
    );
  }

  Widget _buildAspect(BuildContext context) {
    return PortraitHandlingSizedBox(
      widthFactorOnWideDevices: 0.3,
      child: DropdownOptions(
        header: 'Aspect',
        enumValues: Direction.values,
        initialValue: Direction.north,
        onSelected: (selectedOption) {},
      ),
    );
  }

  Widget _buildPercentSlope(BuildContext context) {
    return PortraitHandlingSizedBox(
      widthFactorOnWideDevices: 0.3,
      child: FreeTextBox(
        labelText: '% Slope',
        controller: _slopePercentageController,
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
    const soilHelp =
        "Add any information about the soils that is available to you."
        " This can be from either the landowner, or from online.";
    
    return FreeTextBox(
      controller: _soilInfoController,
      helperText: soilHelp,
      labelText: "Soil Information", 
      onChanged: (text) {
        // Handle soil information text changes
      }
    );
  }
}
