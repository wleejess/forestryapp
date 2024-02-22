import 'package:forestryapp/database/database_manager.dart';
import 'package:forestryapp/database/dto_area.dart';
import 'package:forestryapp/models/area.dart';

class DAOArea {
  // Static Variables //////////////////////////////////////////////////////////
  // Column names in from database when converted to Dart [Map] keys.
  static const colLandowner = 'landowner';
  static const colAcres = 'acres';
  static const colGoals = 'goals';
  static const colElevation = 'elevation';
  static const colAspect = 'aspect';
  static const colSlopePercentage = 'slope percentage';
  static const colSlopePosition = 'slope position';
  static const colSoilInfo = 'soil info';
  static const colCoverType = 'cover type';
  static const colStandStructure = 'stand structure';
  static const colOverstoryDensity = 'overstory density';
  static const colOverstorySpeciesComposition = 'overstory species composition';
  static const colUnderstoryDensity = 'understory density';
  static const colUnderstorySpeciesComposition =
      'understory species composition';
  static const colStandHistory = 'stand history';
  static const colInsects = 'insects';
  static const colDiseases = 'diseases';
  static const colInvasives = 'invasives';
  static const colWildlifeDamage = 'wildlife damage';
  static const colMistletoeUniformity = 'mistletoe uniformity';
  static const colMistletoeLocation = 'mistletoe location';
  static const colHawksworth = 'hawksworth';
  static const colMistletoeTreeSpecies = 'mistletoe tree species';
  static const colRoadHealth = 'road health';
  static const colWaterHealth = 'water health';
  static const colFireRisk = 'fire risk';
  static const colOtherIssues = 'other issues';
  static const colDiagnosis = 'diagnosis';

  // Reading from database /////////////////////////////////////////////////////
  static Future<List<Area>> fetchFromDatabase() async {
    final dbRecords = await DatabaseManager.getInstance().readArea();
    return dbRecords.map((Map record) => Area.fromMap(record)).toList();
  }

  // Writing to Database ///////////////////////////////////////////////////////
  static void saveNewLandowner(DTOArea dto) {
    DatabaseManager.getInstance().saveNewArea([
      // dto.usState.label,
      dto.landowner,
      dto.acres,
      dto.goals,
      dto.elevation,
      dto.aspect,
      dto.slopePercentage,
      dto.slopePosition,
      dto.soilInfo,
      dto.coverType,
      dto.standStructure,
      dto.overstoryDensity,
      dto.overstorySpeciesComposition,
      dto.understoryDensity,
      dto.understorySpeciesComposition,
      dto.standHistory,
      dto.insects,
      dto.diseases,
      dto.invasives,
      dto.widlifeDamage,
      dto.mistletoeUniformity,
      dto.mistletoeLocation,
      dto.hawksworth,
      dto.mistletoeTreeSpecies,
      dto.roadHealth,
      dto.waterHealth,
      dto.fireRisk,
      dto.otherIssues,
      dto.diagnosis
    ]);
  }
}
