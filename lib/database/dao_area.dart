import 'package:forestryapp/database/database_manager.dart';
import 'package:forestryapp/models/area.dart';

class DAOArea {
  // Static Variables //////////////////////////////////////////////////////////
  // Column names in from database when converted to Dart [Map] keys. See
  // [assets/database/schema/areas.sql] for details.
  static const colID = 'id';

  // Basic Information
  static const colLandownerID = 'landowner_id';
  static const colName = 'name';
  static const colAcres = 'acres';
  static const colGoals = 'goals';

  // Site Characteristics
  static const colElevation = 'elevation';
  static const colAspect = 'aspect';
  static const colSlopePercentage = 'slope_percentage';
  static const colSlopePosition = 'slope_position';
  static const colSoilInfo = 'soil_information';

  // Vegetative Conditions
  static const colCoverType = 'cover_type';
  static const colStandStructure = 'stand_structure';
  static const colOverstoryDensity = 'overstory_stand_density';
  static const colOverstorySpeciesComposition = 'overstory_species_composition';
  static const colUnderstoryDensity = 'understory_stand_density';
  static const colUnderstorySpeciesComposition =
      'understory_species_composition';
  static const colStandHistory = 'history';

  // Damages
  static const colInsects = 'insects';
  static const colDiseases = 'diseases';
  static const colInvasives = 'invasives';
  static const colWildlifeDamage = 'wildlife_damage';

  // Mistletoe
  static const colMistletoeUniformity = 'mistletoe_uniformity';
  static const colMistletoeLocation = 'mistletoe_location';
  static const colHawksworth = 'hawksworth';
  static const colMistletoeTreeSpecies = 'mistletoe_tree_species';

  // Free responses
  static const colRoadHealth = 'road_issues';
  static const colWaterHealth = 'water_issues';
  static const colFireRisk = 'fire_risk';
  static const colOtherIssues = 'other_issues';
  static const colDiagnosis = 'diagnosis';

  // Reading from database /////////////////////////////////////////////////////
  static Future<List<Area>> fetchFromDatabase() async {
    final dbRecords = await DatabaseManager.getInstance().readArea();
    return dbRecords.map((Map record) => Area.fromMap(record)).toList();
  }

  // Writing to Database ///////////////////////////////////////////////////////
  static void saveNewArea(Area area) {
    DatabaseManager.getInstance().saveNewArea(_getNonIDFields(area));
  }

  /// Edit an existing area record alreay on the database.
  ///
  /// Assumes [area.id] is a valid ID for an existing area.
  static void updateExistingArea(Area area) => DatabaseManager.getInstance()
      .updateExistingArea([..._getNonIDFields(area), area.id]);

  /// Remove an existing area record from the database.
  ///
  /// Assumes [id] is a valid ID of an existing area record.
  static Future<void> deleteArea(int id) async =>
      DatabaseManager.getInstance().deleteArea([id]);

  // Relationship Queries //////////////////////////////////////////////////////
  static Future<List<Area>> readAreasFromLandowner(int landownerID) async {
    final dbRecords = await DatabaseManager.getInstance()
        .readAreasFromLandowner([landownerID]);

    if (dbRecords.isEmpty) return <Area>[];

    return dbRecords.map((Map record) => Area.fromMap(record)).toList();
  }

  // Helpers ///////////////////////////////////////////////////////////////////

  static List<dynamic> _getNonIDFields(Area area) => [
        (area.landownerID),
        area.name,
        area.acres,
        area.goals,
        area.elevation,
        prepareEnumForDBWrite(area.aspect),
        area.slopePercentage,
        prepareEnumForDBWrite(area.slopePosition),
        area.soilInfo,
        prepareEnumForDBWrite(area.coverType),
        prepareEnumForDBWrite(area.standStructure),
        prepareEnumForDBWrite(area.overstoryDensity),
        area.overstorySpeciesComposition,
        prepareEnumForDBWrite(area.understoryDensity),
        area.understorySpeciesComposition,
        area.standHistory,
        area.insects,
        area.diseases,
        area.invasives,
        area.wildlifeDamage,
        prepareEnumForDBWrite(area.mistletoeUniformity),
        area.mistletoeLocation,
        prepareEnumForDBWrite(area.hawksworth),
        area.mistletoeTreeSpecies,
        area.roadHealth,
        area.waterHealth,
        area.fireRisk,
        area.otherIssues,
        area.diagnosis
      ];

  static String? prepareEnumForDBWrite(dynamic enumValue,
      {String naLabel = 'N/A'}) {
    if (enumValue.label == naLabel) return null;
    return enumValue.label;
  }
}
