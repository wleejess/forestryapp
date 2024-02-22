import 'package:flutter/material.dart';
import 'package:forestryapp/models/landowner.dart';
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
    // Basic Information
    String? name,
    double? acres,
    Landowner? landowner,
    String? goals,

    // Site Characteristics
    String? elevation,
    Direction aspect = Direction.north,
    int? slopePercentage,
    SlopePosition slopePosition = SlopePosition.lower,
    String? soilInfo,

    // Vegetative Conditions
    CoverType coverType = CoverType.forest,
    StandStructure standStructure = StandStructure.evenAged,
    StandDensity overstoryDensity = StandDensity.low,
    int? overstorySpeciesComposition,
    StandDensity understoryDensity = StandDensity.low,
    int? understorySpeciesComposition,
    String? standHistory,

    // Insects and Diseases
    String? insects,
    String? diseases,
    String? invasives,
    String? wildlifeDamage,

    // Mistletoe
    MistletoeUniformity mistletoeUniformity = MistletoeUniformity.uniform,
    String? mistletoeLocation,
    Hawksworth hawksworth = Hawksworth.low,
    String? mistletoeTreeSpecies,

    // Free responses
    String? roadHealth,
    String? waterHealth,
    String? fireRisk,
    String? otherIssues,
    String? diagnosis,
  })  : // Basic Information
        _name = name,
        _acres = acres,
        _landowner = landowner,
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

        // Insects and Diseases
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
            landowner: dbRecord[DAOArea.colLandowner],
            acres: dbRecord[DAOArea.colAcres],
            goals: dbRecord[DAOArea.colGoals],
            elevation: dbRecord[DAOArea.colElevation],
            aspect: dbRecord[DAOArea.colAspect],
            slopePercentage: dbRecord[DAOArea.colSlopePercentage],
            slopePosition: dbRecord[DAOArea.colSlopePosition],
            soilInfo: dbRecord[DAOArea.colSoilInfo],
            coverType: dbRecord[DAOArea.colCoverType],
            standStructure: dbRecord[DAOArea.colStandStructure],
            overstoryDensity: dbRecord[DAOArea.colOverstoryDensity],
            overstorySpeciesComposition:
                dbRecord[DAOArea.colOverstorySpeciesComposition],
            understoryDensity: dbRecord[DAOArea.colUnderstoryDensity],
            understorySpeciesComposition:
                dbRecord[DAOArea.colUnderstorySpeciesComposition],
            standHistory: dbRecord[DAOArea.colStandHistory],
            insects: dbRecord[DAOArea.colInsects],
            diseases: dbRecord[DAOArea.colDiseases],
            invasives: dbRecord[DAOArea.colInvasives],
            wildlifeDamage: dbRecord[DAOArea.colWildlifeDamage],
            mistletoeUniformity: dbRecord[DAOArea.colMistletoeUniformity],
            mistletoeLocation: dbRecord[DAOArea.colMistletoeLocation],
            hawksworth: dbRecord[DAOArea.colHawksworth],
            mistletoeTreeSpecies: dbRecord[DAOArea.colMistletoeTreeSpecies],
            roadHealth: dbRecord[DAOArea.colRoadHealth],
            waterHealth: dbRecord[DAOArea.colWaterHealth],
            fireRisk: dbRecord[DAOArea.colFireRisk],
            otherIssues: dbRecord[DAOArea.colOtherIssues],
            diagnosis: dbRecord[DAOArea.colDiagnosis]);

  // Instance Variables ////////////////////////////////////////////////////////

  // Basic Information
  String? _name;
  double? _acres;
  Landowner? _landowner;
  String? _goals;

  // Site Characteristics
  String? _elevation;
  Direction _aspect;
  int? _slopePercentage;
  SlopePosition _slopePosition;
  String? _soilInfo;

  // Vegetative Conditions
  CoverType _coverType = CoverType.forest;
  StandStructure _standStructure = StandStructure.evenAged;
  StandDensity _overstoryDensity;
  int? _overstorySpeciesComposition;
  StandDensity _understoryDensity = StandDensity.low;
  int? _understorySpeciesComposition;
  String? _standHistory;

  // Insects and Diseases
  String? _insects;
  String? _diseases;
  String? _invasives;
  String? _wildlifeDamage;

  // Mistletoe
  MistletoeUniformity _mistletoeUniformity = MistletoeUniformity.uniform;
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

  Landowner? get landowner => _landowner;

  set landowner(Landowner? value) {
    _landowner = value;
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

  String? get elevation => _elevation;

  set elevation(String? value) {
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
