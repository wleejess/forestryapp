import 'package:flutter/material.dart';
import "package:forestryapp/enums/slope_position.dart";
import "package:forestryapp/enums/direction.dart";
import 'package:forestryapp/enums/stand_structure.dart';
import 'package:forestryapp/enums/cover_type.dart';
import 'package:forestryapp/enums/stand_density.dart';
import 'package:forestryapp/enums/hawksworth.dart';
import 'package:forestryapp/enums/mistletoe_uniformity.dart';
import 'package:forestryapp/database/dao_area.dart';

class Area extends ChangeNotifier {
  Area({
    int? id,

    // Basic Information
    int? landownerID,
    String? name,
    double? acres,
    String? goals,

    // Site Characteristics
    int? elevation,
    Direction aspect = Direction.na,
    int? slopePercentage,
    SlopePosition slopePosition = SlopePosition.na,
    String? soilInfo,

    // Vegetative Conditions
    CoverType coverType = CoverType.forest,
    StandStructure standStructure = StandStructure.na,
    StandDensity overstoryDensity = StandDensity.na,
    int? overstorySpeciesComposition,
    StandDensity understoryDensity = StandDensity.na,
    int? understorySpeciesComposition,
    String? standHistory,

    // Damages
    String? insects,
    String? diseases,
    String? invasives,
    String? wildlifeDamage,

    // Mistletoe
    MistletoeUniformity mistletoeUniformity = MistletoeUniformity.na,
    String? mistletoeLocation,
    Hawksworth hawksworth = Hawksworth.na,
    String? mistletoeTreeSpecies,

    // Free responses
    String? roadHealth,
    String? waterHealth,
    String? fireRisk,
    String? otherIssues,
    String? diagnosis,
  })  : _id = id,
        // Basic Information
        _landownerID = landownerID,
        _name = name,
        _acres = acres,
        _goals = goals,

        // Site Characteristics
        _elevation = elevation,
        _aspect = aspect,
        _slopePercentage = slopePercentage,
        _slopePosition = slopePosition,
        _soilInfo = soilInfo,

        // Vegetative Conditions
        _coverType = coverType,
        _standStructure = standStructure,
        _overstoryDensity = overstoryDensity,
        _overstorySpeciesComposition = overstorySpeciesComposition,
        _understoryDensity = understoryDensity,
        _understorySpeciesComposition = understorySpeciesComposition,
        _standHistory = standHistory,

        // Damages
        _insects = insects,
        _diseases = diseases,
        _invasives = invasives,
        _wildlifeDamage = wildlifeDamage,

        // Mistletoe
        _mistletoeUniformity = mistletoeUniformity,
        _mistletoeLocation = mistletoeLocation,
        _hawksworth = hawksworth,
        _mistletoeTreeSpecies = mistletoeTreeSpecies,

        // Free responses
        _roadHealth = roadHealth,
        _waterHealth = waterHealth,
        _fireRisk = fireRisk,
        _otherIssues = otherIssues,
        _diagnosis = diagnosis;

  Area.fromMap(Map dbRecord)
      : this(
            id: int.tryParse(dbRecord[DAOArea.colID]),

            // Basic Information
            landowner: dbRecord[DAOArea.colLandowner], // TODO: Change to int
            name: dbRecord[DAOArea.colName],
            acres: double.tryParse(dbRecord[DAOArea.colAcres]),
            goals: dbRecord[DAOArea.colGoals],

            // Site Characteristics
            elevation: int.tryParse(dbRecord[DAOArea.colElevation]),
            aspect: _convertDBToEnum(dbRecord[DAOArea.colAspect], Direction),
            slopePercentage: int.tryParse(dbRecord[DAOArea.colSlopePercentage]),
            slopePosition: _convertDBToEnum(
              dbRecord[DAOArea.colSlopePosition],
              SlopePosition,
            ),
            soilInfo: dbRecord[DAOArea.colSoilInfo],

            // Vegetative Conditions
            coverType: _convertDBToEnum(
              dbRecord[DAOArea.colCoverType],
              CoverType,
            ),
            standStructure: _convertDBToEnum(
                dbRecord[DAOArea.colStandStructure], StandStructure),
            overstoryDensity: _convertDBToEnum(
              dbRecord[DAOArea.colOverstoryDensity],
              StandDensity,
            ),
            overstorySpeciesComposition: int.tryParse(
              dbRecord[DAOArea.colOverstorySpeciesComposition],
            ),
            understoryDensity: _convertDBToEnum(
              dbRecord[DAOArea.colUnderstoryDensity],
              StandDensity,
            ),
            understorySpeciesComposition: int.tryParse(
              dbRecord[DAOArea.colUnderstorySpeciesComposition],
            ),
            standHistory: dbRecord[DAOArea.colStandHistory],

            // Damages
            insects: dbRecord[DAOArea.colInsects],
            diseases: dbRecord[DAOArea.colDiseases],
            invasives: dbRecord[DAOArea.colInvasives],
            wildlifeDamage: dbRecord[DAOArea.colWildlifeDamage],

            // Mistletoe
            mistletoeUniformity: _convertDBToEnum(
              dbRecord[DAOArea.colMistletoeUniformity],
              MistletoeUniformity,
            ),
            mistletoeLocation: dbRecord[DAOArea.colMistletoeLocation],
            hawksworth: _convertDBToEnum(
              dbRecord[DAOArea.colHawksworth],
              Hawksworth,
            ),
            mistletoeTreeSpecies: dbRecord[DAOArea.colMistletoeTreeSpecies],

            // Free responses
            roadHealth: dbRecord[DAOArea.colRoadHealth],
            waterHealth: dbRecord[DAOArea.colWaterHealth],
            fireRisk: dbRecord[DAOArea.colFireRisk],
            otherIssues: dbRecord[DAOArea.colOtherIssues],
            diagnosis: dbRecord[DAOArea.colDiagnosis]);

  /// Gets appropriate enum for a given database column.
  ///
  /// Assumes each [enumForCol] has a [na] member representing an "N/A" option.
  /// Should only be used in [.fromMap()]. [databaseValue] will be the string
  /// returned from a given record for one of the columns that uses
  /// [enum]s. [enumForCol] is said [enum] class
  /// (e.g. [/lib/enums/hawksworth.dart]).
  static dynamic _convertDBToEnum(String? databaseValue, dynamic enumForCol) {
    if (databaseValue == null) return enumForCol.na;
    for (var enumValue in enumForCol.values) {
      if (databaseValue == enumValue.label) return enumValue;
    }
    return enumForCol.na;
  }

  // Instance Variables ////////////////////////////////////////////////////////
  int? _id;

  // Basic Information
  /// Store the ID instead of the object because when the Area record comes off
  /// the database only an ID (the foreign key) is available to be set here.
  int? _landownerID;
  String? _name;
  double? _acres;
  String? _goals;

  // Site Characteristics
  int? _elevation;
  Direction _aspect = Direction.na;
  int? _slopePercentage;
  SlopePosition _slopePosition;
  String? _soilInfo;

  // Vegetative Conditions
  CoverType _coverType = CoverType.na;
  StandStructure _standStructure = StandStructure.na;
  StandDensity _overstoryDensity;
  int? _overstorySpeciesComposition;
  StandDensity _understoryDensity = StandDensity.na;
  int? _understorySpeciesComposition;
  String? _standHistory;

  // Damages
  String? _insects;
  String? _diseases;
  String? _invasives;
  String? _wildlifeDamage;

  // Mistletoe
  MistletoeUniformity _mistletoeUniformity = MistletoeUniformity.na;
  String? _mistletoeLocation;
  Hawksworth _hawksworth;
  String? _mistletoeTreeSpecies;

  // Free responses
  String? _roadHealth;
  String? _waterHealth;
  String? _fireRisk;
  String? _otherIssues;
  String? _diagnosis;

  // Getters and Setters ///////////////////////////////////////////////////////

  int? get id => _id;

  set id(int? value) {
    _id = value;
    notifyListeners();
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  double? get acres => _acres;

  set acres(double? value) {
    _acres = value;
    notifyListeners();
  }

  int? get landownerID => _landownerID;

  set landownerID(int? value) {
    _landownerID = value;
    notifyListeners();
  }

  String? get goals => _goals;

  set goals(String? value) {
    _goals = value;
    notifyListeners();
  }

  SlopePosition get slopePosition => _slopePosition;

  set slopePosition(SlopePosition value) {
    _slopePosition = value;
    notifyListeners();
  }

  int? get elevation => _elevation;

  set elevation(int? value) {
    _elevation = value;
    notifyListeners();
  }

  Direction get aspect => _aspect;

  set aspect(Direction value) {
    _aspect = value;
    notifyListeners();
  }

  int? get slopePercentage => _slopePercentage;

  set slopePercentage(int? value) {
    _slopePercentage = value;
    notifyListeners();
  }

  String? get soilInfo => _soilInfo;

  set soilInfo(String? value) {
    _soilInfo = value;
    notifyListeners();
  }

  CoverType get coverType => _coverType;

  set coverType(CoverType value) {
    _coverType = value;
    notifyListeners();
  }

  StandStructure get standStructure => _standStructure;

  set standStructure(StandStructure value) {
    _standStructure = value;
    notifyListeners();
  }

  StandDensity get overstoryDensity => _overstoryDensity;

  set overstoryDensity(StandDensity value) {
    _overstoryDensity = value;
    notifyListeners();
  }

  int? get overstorySpeciesComposition => _overstorySpeciesComposition;

  set overstorySpeciesComposition(int? value) {
    _overstorySpeciesComposition = value;
    notifyListeners();
  }

  StandDensity get understoryDensity => _understoryDensity;

  set understoryDensity(StandDensity value) {
    _understoryDensity = value;
    notifyListeners();
  }

  int? get understorySpeciesComposition => _understorySpeciesComposition;

  set understorySpeciesComposition(int? value) {
    _understorySpeciesComposition = value;
    notifyListeners();
  }

  String? get standHistory => _standHistory;

  set standHistory(String? value) {
    _standHistory = value;
    notifyListeners();
  }

  String? get insects => _insects;

  set insects(String? value) {
    _insects = value;
    notifyListeners();
  }

  String? get diseases => _diseases;

  set diseases(String? value) {
    _diseases = value;
    notifyListeners();
  }

  String? get invasives => _invasives;

  set invasives(String? value) {
    _invasives = value;
    notifyListeners();
  }

  String? get wildlifeDamage => _wildlifeDamage;

  set wildlifeDamage(String? value) {
    _wildlifeDamage = value;
    notifyListeners();
  }

  MistletoeUniformity get mistletoeUniformity => _mistletoeUniformity;

  set mistletoeUniformity(MistletoeUniformity value) {
    _mistletoeUniformity = value;
    notifyListeners();
  }

  Hawksworth get hawksworth => _hawksworth;

  set hawksworth(Hawksworth value) {
    _hawksworth = value;
    notifyListeners();
  }

  String? get mistletoeLocation => _mistletoeLocation;

  set mistletoeLocation(String? value) {
    _mistletoeLocation = value;
    notifyListeners();
  }

  String? get mistletoeTreeSpecies => _mistletoeTreeSpecies;

  set mistletoeTreeSpecies(String? value) {
    _mistletoeTreeSpecies = value;
    notifyListeners();
  }

  String? get roadHealth => _roadHealth;

  set roadHealth(String? value) {
    _roadHealth = value;
    notifyListeners();
  }

  String? get waterHealth => _waterHealth;

  set waterHealth(String? value) {
    _waterHealth = value;
    notifyListeners();
  }

  String? get fireRisk => _fireRisk;

  set fireRisk(String? value) {
    _fireRisk = value;
    notifyListeners();
  }

  String? get otherIssues => _otherIssues;

  set otherIssues(String? value) {
    _otherIssues = value;
    notifyListeners();
  }

  String? get diagnosis => _diagnosis;

  set diagnosis(String? value) {
    _diagnosis = value;
    notifyListeners();
  }
}
