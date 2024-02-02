import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

class AreaReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";

  static const _placeholderForOmitted = "Omitted";
  static const _unitElevation = 'ft';
  static const _unitSlopePercentage = "%";
  static const _unitSpeciesComposition = "%";

  // Instance variables ////////////////////////////////////////////////////////

  final String _name;

  final String? _landowner,
      _acres,
      _goals,
      _elevation,
      _aspect,
      _slopePercentage,
      _slopePosition,
      _soilInfo,
      _coverType,
      _standStructure,
      _overstoryDensity,
      _overstorySpeciesComposition,
      _understoryDensity,
      _understorySpeciesComposition,
      _siteHistory,
      _insects,
      _diseases,
      _ivasives,
      _wildlifeDamage,
      _mistletoeUniformity,
      _mistletoeLocation,
      _hawksworth,
      _mistletoeTreeSpecies,
      _roadHealth,
      _waterHealth,
      _fireRisk,
      _otherIssues,
      _diagnosis;

  // Constructor ///////////////////////////////////////////////////////////////
  const AreaReview({
    required String name,
    String? landowner,
    String? acres,
    String? goals,
    String? elevation,
    String? aspect,
    String? slopePercentage,
    String? slopePosition,
    String? soilInfo,
    String? coverType,
    String? standStructure,
    String? overstoryDensity,
    String? overstorySpeciesComposition,
    String? understoryDensity,
    String? understorySpeciesComposition,
    String? siteHistory,
    String? insects,
    String? diseases,
    String? ivasives,
    String? wildlifeDamage,
    String? mistletoeUniformity,
    String? mistletoeLocation,
    String? hawksworth,
    String? mistletoeTreeSpecies,
    String? roadHealth,
    String? waterHealth,
    String? fireRisk,
    String? otherIssues,
    String? diagnosis,
    super.key,
  })  : _name = name,
        _landowner = landowner,
        _acres = acres,
        _goals = goals,
        _elevation = elevation,
        _aspect = aspect,
        _slopePercentage = slopePercentage,
        _slopePosition = slopePosition,
        _soilInfo = soilInfo,
        _coverType = coverType,
        _standStructure = standStructure,
        _overstoryDensity = overstoryDensity,
        _overstorySpeciesComposition = overstorySpeciesComposition,
        _understoryDensity = understoryDensity,
        _understorySpeciesComposition = understorySpeciesComposition,
        _siteHistory = siteHistory,
        _insects = insects,
        _diseases = diseases,
        _ivasives = ivasives,
        _wildlifeDamage = wildlifeDamage,
        _mistletoeUniformity = mistletoeUniformity,
        _mistletoeLocation = mistletoeLocation,
        _hawksworth = hawksworth,
        _mistletoeTreeSpecies = mistletoeTreeSpecies,
        _roadHealth = roadHealth,
        _waterHealth = waterHealth,
        _fireRisk = fireRisk,
        _otherIssues = otherIssues,
        _diagnosis = diagnosis;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: "$_titlePrefix: $_name",
      body: Column(
        children: [
          Expanded(child: _buildAreaPropertiesListView(context)),
          _buildButtonRow(context),
        ],
      ),
    );
  }

  // Heading ///////////////////////////////////////////////////////////////////

  // Area Properties ///////////////////////////////////////////////////////////

  Widget _buildAreaPropertiesListView(BuildContext context) {
    // For now, use `ListView` instead of `ListView.builder` to give finer
    // control over order in which checklist items appear as well as allowing
    // future tweaking of appearance of certain properties (e.g. landowner
    // should be tappable to navigate to landowner, multi-valued properties may
    // be displayed in a list).
    return ListView(
      children: [
        ListTile(
          title: Text(_name, style: Theme.of(context).textTheme.headlineLarge),
        ),
        _buildAreaPropertyListTile(context, "Landowner", _landowner),
        _buildAreaPropertyListTile(context, "Acres", _acres),
        _buildAreaPropertyListTile(context, "Goals and Objectives", _goals),
        _buildAreaPropertyListTile(context, "Elevation",
            _appendUnitsToValue(_elevation, _unitElevation)),
        _buildAreaPropertyListTile(context, "Aspect", _aspect),
        _buildAreaPropertyListTile(context, "Slope",
            _appendUnitsToValue(_slopePercentage, _unitSlopePercentage)),
        _buildAreaPropertyListTile(context, "Slope Position", _slopePosition),
        _buildAreaPropertyListTile(context, "Soil Information", _soilInfo),
        _buildAreaPropertyListTile(context, "Cover Type", _coverType),
        _buildAreaPropertyListTile(context, "Stand Structure", _standStructure),
        _buildAreaPropertyListTile(
            context, "Overstory Stand Density", _overstoryDensity),
        _buildAreaPropertyListTile(
          context,
          "Overstory Species Composition",
          _appendUnitsToValue(
              _overstorySpeciesComposition, _unitSpeciesComposition),
        ),
        _buildAreaPropertyListTile(
            context, "Understory Stand Density", _understoryDensity),
        _buildAreaPropertyListTile(
          context,
          "Understory Species Composition",
          _appendUnitsToValue(
              _understorySpeciesComposition, _unitSpeciesComposition),
        ),
        _buildAreaPropertyListTile(context, "Site History", _siteHistory),
        _buildAreaPropertyListTile(context, "Insects", _insects),
        _buildAreaPropertyListTile(context, "Diseases", _diseases),
        _buildAreaPropertyListTile(context, "Ivasives", _ivasives),
        _buildAreaPropertyListTile(context, "Wildlife Damage", _wildlifeDamage),
        _buildAreaPropertyListTile(
            context, "Mistletoe Uniformity", _mistletoeUniformity),
        _buildAreaPropertyListTile(
            context, "Mistletoe Location", _mistletoeLocation),
        _buildAreaPropertyListTile(
            context, "Hawksworth Infectino Rating", _hawksworth),
        _buildAreaPropertyListTile(
            context, "Mistletoe Tree Species", _mistletoeTreeSpecies),
        _buildAreaPropertyListTile(context, "Road Health", _roadHealth),
        _buildAreaPropertyListTile(context, "Water Health", _waterHealth),
        _buildAreaPropertyListTile(context, "Fire Risk", _fireRisk),
        _buildAreaPropertyListTile(context, "Other Issues", _otherIssues),
        _buildAreaPropertyListTile(context, "Diagnosis", _diagnosis),
      ],
    );
  }

  /// Create a formatted string with units appended or `null` if omitted.
  ///
  /// Append the the specified [units] to given [value]. If [value] is `null`
  /// just return `null`.
  String? _appendUnitsToValue(String? value, String units) {
    return (value == null) ? null : "$value $units";
  }

  Widget _buildAreaPropertyListTile(
    BuildContext context,
    String propertyLabel,
    String? property,
  ) {
    final TextStyle? styleProperty = Theme.of(context).textTheme.headlineSmall;
    final TextStyle styleLabel =
        styleProperty!.copyWith(fontWeight: FontWeight.bold);

    return ListTile(
      // Use `Wrap` to push property down underneath the label when too long.
      title: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: [
          Text("$propertyLabel: ", style: styleLabel),
          Text(property ?? _placeholderForOmitted, style: styleProperty),
        ],
      ),
    );
  }

  // Buttons ///////////////////////////////////////////////////////////////////
  _buildButtonRow(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(onPressed: () {}, child: const Text("Generate PDF")),
        OutlinedButton(onPressed: () {}, child: const Text("Send Email")),
        Expanded(child: Container()),
        OutlinedButton(onPressed: () {}, child: const Text("Edit")),
        OutlinedButton(onPressed: () {}, child: const Text("Delete")),
      ],
    );
  }
}
