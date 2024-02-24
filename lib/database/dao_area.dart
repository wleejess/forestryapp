import 'package:forestryapp/database/database_manager.dart';
import 'package:forestryapp/database/dto_area.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/models/landowner.dart';

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
  static void saveNewArea(DTOArea dto) {
    DatabaseManager.getInstance().saveNewArea([
      (dto.landownerID != null) ? dto.landownerID : null,
      dto.name,
      dto.acres,
      dto.goals,
      dto.elevation,
      dto.direction.label,
      dto.slopePercentage,
      dto.slopePosition.label,
      dto.soilInfo,
      dto.coverType.label,
      dto.standStructure.label,
      dto.overstoryDensity.label,
      dto.overstorySpeciesComposition,
      dto.understoryDensity.label,
      dto.understorySpeciesComposition,
      dto.standHistory,
      dto.insects,
      dto.diseases,
      dto.invasives,
      dto.wildlifeDamage,
      dto.mistletoeUniformity.label,
      dto.mistletoeLocation,
      dto.hawksworth.label,
      dto.mistletoeTreeSpecies,
      dto.roadHealth,
      dto.waterHealth,
      dto.fireRisk,
      dto.otherIssues,
      dto.diagnosis
    ]);
  }

  // Relationship Queries //////////////////////////////////////////////////////
  static Future<Landowner?> readLandownerFromArea(int areaID) async {
    final dbRecords =
        await DatabaseManager.getInstance().readLandownerFromArea([areaID]);

    if (dbRecords.isEmpty) return null;

    return Landowner.fromMap(dbRecords[0]);
  }
}
