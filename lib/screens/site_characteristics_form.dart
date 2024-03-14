import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/components/dropdown.dart";
import "package:forestryapp/components/radio_options.dart";
import "package:forestryapp/enums/slope_position.dart";
import "package:forestryapp/enums/direction.dart";
import "package:forestryapp/screens/basic_information_form.dart";
import "package:forestryapp/screens/vegetative_conditions_form.dart";
import "package:forestryapp/util/validation.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/components/unsaved_changes.dart';

/// Represents a form for capturing site characteristics of the area.
///
/// This form allows users to input various site characteristics such as elevation,
/// aspect, slope percentage, slope position, and soil information.
class SiteCharacteristicsForm extends StatelessWidget {
  // Static Variables
  static const _title = "Site Characteristics";

  final _formKey = GlobalKey<FormState>();

  // Constructor ////////////////////////////////////////////////////////////////
  /// Creates a screen for capturing site characteristics.
  SiteCharacteristicsForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: SiteCharacteristicsForm._title,
        body: FormScaffold(
            prevPage: BasicInformationForm(),
            nextPage: VegetativeConditionsForm(),
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
            )));
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a text input field to enter the elevation of the area.
  Widget _buildElevation(BuildContext context) {
    final elevationData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

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
            unsavedChangesNotifier.setUnsavedChanges(true);
          }
        },
        validator: Validation.isValidElevation,
        keyboardType: TextInputType.number,
      ),
    );
  }

  /// Builds a dropdown menu to select the aspect of the area.
  Widget _buildAspect(BuildContext context) {
    final aspectData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return PortraitHandlingSizedBox(
      widthFactorOnWideDevices: 0.3,
      child: DropdownOptions(
        header: 'Aspect',
        enumValues: Direction.values,
        initialValue: aspectData.aspect,
        onSelected: (selectedOption) {
          aspectData.aspect = selectedOption;
          unsavedChangesNotifier.setUnsavedChanges(true);
        },
      ),
    );
  }

  /// Builds a text input field to enter the slope percentage of the area.
  Widget _buildPercentSlope(BuildContext context) {
    final percentSlopeData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

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
            unsavedChangesNotifier.setUnsavedChanges(true);
          }
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: Validation.isValidPercentage,
      ),
    );
  }

  /// Builds radio options to select the slope position of the area.
  Widget _buildSlopePosition(BuildContext context) {
    final slopePositionData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return RadioOptions(
        header: 'Slope Position:',
        enumValues: SlopePosition.values,
        initialValue: slopePositionData.slopePosition,
        onSelected: (selectedOption) {
          slopePositionData.slopePosition = selectedOption;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }

  /// Builds a text input field to enter soil information of the area.
  Widget _buildSoilInformation(BuildContext context) {
    const soilHelp =
        "Add any information about the soils that is available to you."
        " This can be from either the landowner, or from online.";

    final soilInfoData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return TextFormField(
        decoration: const InputDecoration(
          helperText: soilHelp,
          labelText: "Soil Information",
        ),
        initialValue: soilInfoData.soilInfo,
        onChanged: (text) {
          soilInfoData.soilInfo = text;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }
}
