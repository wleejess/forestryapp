import "package:flutter/material.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/util/validation.dart";
import "package:provider/provider.dart";

/// Component to list all the properties of an [Area] in a single place for
/// reviewing by a user.
class AreaProperties extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _placeholderForOmitted = "N/A";
  static const _unitElevation = 'ft';
  static const _unitSlopePercentage = "%";
  static const _unitSpeciesComposition = "%";

  // Instance Variables ////////////////////////////////////////////////////////
  final Area _area;

  // Constructor ///////////////////////////////////////////////////////////////
  const AreaProperties(Area area, {super.key}) : _area = area;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // For now, use `ListView` instead of `ListView.builder` to give finer
    // control over order in which checklist items appear as well as allowing
    // future tweaking of appearance of certain properties (e.g. landowner
    // should be tappable to navigate to landowner, multi-valued properties may
    // be displayed in a list).
    return ListView(
      children: [
        // Basic Information ///////////////////////////////////////////////////
        ListTile(
          title: Text(_area.name ?? _placeholderForOmitted,
              style: Theme.of(context).textTheme.headlineLarge),
          tileColor: _area.name == null ? Theme.of(context).colorScheme.errorContainer : null,
          subtitle: _area.name == null ? 
            Text(
              "Please enter an area name.",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              ) : null,
        ),
        // TODO: make this listenable
        _buildLandowner(
          context,
        ),
        _buildAreaPropertyListTile(
          context,
          "Acres",
          _formatDouble(_area.acres),
          Validation.isValidAcres(_area.acres)
        ),
        _buildAreaPropertyListTile(
          context,
          "Goals and Objectives",
          _area.goals,
        ),

        // Site Characteristics ////////////////////////////////////////////////
        _buildAreaPropertyListTile(
          context,
          "Elevation",
          _formatInt(_area.elevation, units: _unitElevation),
          Validation.isInteger(_area.elevation)
        ),
        _buildAreaPropertyListTile(
          context,
          "Aspect",
          _area.aspect.label,
        ),
        _buildAreaPropertyListTile(
          context,
          "Slope Percentage",
          _formatInt(_area.slopePercentage, units: _unitSlopePercentage),
          Validation.isValidPercentage(_area.slopePercentage)
        ),
        _buildAreaPropertyListTile(
          context,
          "Slope Position",
          _area.slopePosition.label,
        ),
        _buildAreaPropertyListTile(
          context,
          "Soil Information",
          _area.soilInfo,
        ),

        // Vegetative Conditions ///////////////////////////////////////////////
        _buildAreaPropertyListTile(
          context,
          "Cover Type",
          _area.coverType.label,
        ),
        _buildAreaPropertyListTile(
          context,
          "Stand Structure",
          _area.standStructure.label,
        ),
        _buildAreaPropertyListTile(
          context,
          "Overstory Stand Density",
          _area.overstoryDensity.label,
        ),
        _buildAreaPropertyListTile(
          context,
          "Overstory Species Composition",
          _formatInt(_area.overstorySpeciesComposition,
              units: _unitSpeciesComposition),
          Validation.isValidPercentage(_area.overstorySpeciesComposition)
        ),
        _buildAreaPropertyListTile(
          context,
          "Understory Stand Density",
          _area.understoryDensity.label,
        ),
        _buildAreaPropertyListTile(
          context,
          "Understory Species Composition",
          _formatInt(_area.understorySpeciesComposition,
              units: _unitSpeciesComposition),
          Validation.isValidPercentage(_area.understorySpeciesComposition)
        ),
        _buildAreaPropertyListTile(
          context,
          "Stand History",
          _area.standHistory,
        ),

        // Damages /////////////////////////////////////////////////////////////
        _buildAreaPropertyListTile(
          context,
          "Insects",
          _area.insects,
        ),
        _buildAreaPropertyListTile(
          context,
          "Diseases",
          _area.diseases,
        ),
        _buildAreaPropertyListTile(
          context,
          "Ivasives",
          _area.invasives,
        ),
        // Mistletoe ///////////////////////////////////////////////////////////
        _buildAreaPropertyListTile(
          context,
          "Wildlife Damage",
          _area.wildlifeDamage,
        ),
        _buildAreaPropertyListTile(
          context,
          "Mistletoe Uniformity",
          _area.mistletoeUniformity.label,
        ),
        _buildAreaPropertyListTile(
          context,
          "Mistletoe Location",
          _area.mistletoeLocation,
        ),
        _buildAreaPropertyListTile(
          context,
          "Hawksworth Infection Rating",
          _area.hawksworth.label,
        ),
        _buildAreaPropertyListTile(
          context,
          "Mistletoe Tree Species",
          _area.mistletoeTreeSpecies,
        ),

        // Free Responses //////////////////////////////////////////////////////
        _buildAreaPropertyListTile(context, "Road Health", _area.roadHealth),
        _buildAreaPropertyListTile(context, "Water Health", _area.waterHealth),
        _buildAreaPropertyListTile(context, "Fire Risk", _area.fireRisk),
        _buildAreaPropertyListTile(context, "Other Issues", _area.otherIssues),
        _buildAreaPropertyListTile(context, "Diagnosis", _area.diagnosis),
      ],
    );
  }

  Widget _buildLandowner(BuildContext context) {
    final landowner =
        Provider.of<LandownerCollection>(context).landownerOfReviewedArea;
    final String? landownerName = (landowner == null) ? null : landowner.name;

    return _buildAreaPropertyListTile(context, "Landowner", landownerName);
  }

  String? _formatInt(int? value, {String? units}) =>
      _formatNumber(value, units);
  String? _formatDouble(double? value, {String? units}) =>
      _formatNumber(value, units);

  /// Create a formatted string with units appended or `null` if omitted.
  ///
  /// Append the the specified [units] to given [value]. If [value] is `null`
  /// just return `null`. If [units] is ommited, don't append anything after the
  /// numerical value.
  String? _formatNumber(dynamic value, String? units) {
    if (value == null) return null; // Don't bother formatting if value ommited.
    final String unitSuffix = (units == null) ? '' : ' $units';
    return "$value$unitSuffix";
  }

  Widget _buildAreaPropertyListTile(
    BuildContext context,
    String propertyLabel,
    String? property,
    [String? errorMessage]
  ) {
    final TextStyle? styleProperty = Theme.of(context).textTheme.headlineSmall;
    final TextStyle styleLabel =
        styleProperty!.copyWith(fontWeight: FontWeight.bold);

    return ListTile(
      // Use `Wrap` to push property down underneath the label when too long.
      tileColor: errorMessage != null ? Theme.of(context).colorScheme.errorContainer : null,
      title: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: [
          Text("$propertyLabel: ", style: styleLabel),
          Text(property ?? _placeholderForOmitted, style: styleProperty),
        ],
      ),
      subtitle: errorMessage != null ? 
      Text(
        errorMessage,
        style: TextStyle(color: Theme.of(context).colorScheme.error)
      ) : null,
    );
  }
}
