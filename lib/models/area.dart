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
    name = '',
    landowner = '',
    acres = '',
    goals = '',

    // Site Characteristics
    elevation = '',
    aspect = '',
    slopePercentage = '',
    slopePosition = '',
    soilInfo = '',

    // Vegetative Conditions
    coverType = '',
    standStructure = '',
    overstoryDensity = '',
    overstorySpeciesComposition = '',
    understoryDensity = '',
    understorySpeciesComposition = '',
    standHistory = '',

    // Insects and Diseases
    insects = '',
    diseases = '',
    invasives = '',
    wildlifeDamage = '',

    // Mistletoe
    mistletoeUniformity = '',
    mistletoeLocation = '',
    hawksworth = '',
    mistletoeTreeSpecies = '',

    // Free responses
    roadHealth = '',
    waterHealth = '',
    fireRisk = '',
    otherIssues = '',
    diagnosis = '',
  })  : _landowner = landowner,
        _name = name,
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
        _standHistory = standHistory,
        _insects = insects,
        _invasives = invasives,
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

  String? _name;
  double? _acres;
  Landowner? _landowner;
  String? _goals;
  String? _elevation;
  SlopePosition _slopePosition = SlopePosition.lower;
  Direction _aspect = Direction.north;
  String _slopePercentage = '';
  String _soilInfo = '';
  CoverType _coverType = CoverType.forest;
  StandStructure _standStructure = StandStructure.evenAged;
  StandDensity _overstoryDensity = StandDensity.low;
  String? _overstorySpeciesComposition;
  String? _overstorySlope;
  StandDensity _understoryDensity = StandDensity.low;
  String? _understorySpeciesComposition;
  String _understorySlope = '';
  String _standHistory = '';
  String? _insects;
  String? _diseases;
  String? _invasives;
  String? _wildlifeDamage;
  MistletoeUniformity _mistletoeUniformity = MistletoeUniformity.uniform;
  Hawksworth _hawksworth = Hawksworth.none;
  String? _mistletoeLocation;
  String? _mistletoeTreeSpecies;
  String? _roadHealth;
  String? _waterHealth;
  String? _fireRisk;
  String? _otherIssues;
  String? _diagnosis;

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

  String get slopePercentage => _slopePercentage;

  set slopePercentage(String value) {
    _slopePercentage = value;
    notifyListeners();
  }

  String get soilInfo => _soilInfo;

  set soilInfo(String value) {
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

  String? get overstorySpeciesComposition => _overstorySpeciesComposition;

  set overstorySpeciesComposition(String? value) {
    _overstorySpeciesComposition = value;
    notifyListeners();
  }

  String? get overstorySlope => _overstorySlope;

  set overstorySlope(String? value) {
    _overstorySlope = value;
    notifyListeners();
  }

  StandDensity get understoryDensity => _understoryDensity;

  set understoryDensity(StandDensity value) {
    _understoryDensity = value;
    notifyListeners();
  }

  String? get understorySpeciesComposition => _understorySpeciesComposition;

  set understorySpeciesComposition(String? value) {
    _understorySpeciesComposition = value;
    notifyListeners();
  }

  String get understorySlope => _understorySlope;

  set understorySlope(String value) {
    _understorySlope = value;
    notifyListeners();
  }

  String get standHistory => _standHistory;

  set standHistory(String value) {
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
