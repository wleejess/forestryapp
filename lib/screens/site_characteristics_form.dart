import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/components/dropdown.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/enums/slope_position.dart";
import "package:forestryapp/enums/direction.dart";
import "package:forestryapp/util/validation.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';

class SiteCharacteristicsForm extends StatelessWidget {
  // Static Variables
  static const _title = "Site Characteristics";

  final _formKey = GlobalKey<FormState>();

  SiteCharacteristicsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        title: SiteCharacteristicsForm._title,
        body: FormScaffold(
          child: Form(
            key: _formKey,
            child: Wrap(
              children: [
                _buildAspect(context),
                _buildElevation(context),
                _buildPercentSlope(context),
                _buildSlopePosition(context),
                _buildSoilInformation(context)
              ],
            ),
          )
        ));
  }

  Widget _buildElevation(BuildContext context) {
    final elevationData = Provider.of<Area>(context);

    return PortraitHandlingSizedBox(
      widthFactorOnWideDevices: 0.3,
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Elevation',
          helperText: '',
        ),
        initialValue: elevationData.elevation?.toString(),
        onChanged: (text) {
          if (_formKey.currentState!.validate()) {
            elevationData.elevation = int.tryParse(text);
          }
        },
        validator: Validation.isValidElevation,
      ),
    );
  }

  Widget _buildAspect(BuildContext context) {
    final aspectData = Provider.of<Area>(context);

    return PortraitHandlingSizedBox(
      widthFactorOnWideDevices: 0.3,
      child: DropdownOptions(
        header: 'Aspect',
        enumValues: Direction.values,
        initialValue: aspectData.aspect,
        onSelected: (selectedOption) {
          aspectData.aspect = selectedOption;
        },
      ),
    );
  }

  Widget _buildPercentSlope(BuildContext context) {
    final percentSlopeData = Provider.of<Area>(context);

    return PortraitHandlingSizedBox(
      widthFactorOnWideDevices: 0.3,
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: '% Slope',
          helperText: 'Write in the approximate or average percent slope.',
        ),
        initialValue: percentSlopeData.slopePercentage?.toString(),
        onChanged: (text) {
          if (_formKey.currentState!.validate()) {
            percentSlopeData.slopePercentage = int.tryParse(text);
          }
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: Validation.isValidPercentage,
      ),
    );
  }

  Widget _buildSlopePosition(BuildContext context) {
    final slopePositionData = Provider.of<Area>(context);

    return RadioOptions(
        header: 'Slope Position:',
        enumValues: SlopePosition.values,
        initialValue: slopePositionData.slopePosition,
        onSelected: (selectedOption) {
          slopePositionData.slopePosition = selectedOption;
        });
  }

  Widget _buildSoilInformation(BuildContext context) {
    const soilHelp =
        "Add any information about the soils that is available to you."
        " This can be from either the landowner, or from online.";

    final soilInfoData = Provider.of<Area>(context);

    return TextFormField(
        decoration: const InputDecoration(
          helperText: soilHelp,
          labelText: "Soil Information",
        ),
        initialValue: soilInfoData.soilInfo,
        onChanged: (text) {
          soilInfoData.soilInfo = text;
        });
  }
}
