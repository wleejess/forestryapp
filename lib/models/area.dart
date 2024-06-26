import 'package:flutter/material.dart';
import "package:forestryapp/enums/slope_position.dart";
import "package:forestryapp/enums/direction.dart";
import 'package:forestryapp/enums/stand_structure.dart';
import 'package:forestryapp/enums/cover_type.dart';
import 'package:forestryapp/enums/stand_density.dart';
import 'package:forestryapp/enums/hawksworth.dart';
import 'package:forestryapp/enums/mistletoe_uniformity.dart';
import 'package:forestryapp/database/dao_area.dart';

/// Represents an area within a forestry context.
///
/// This class encapsulates various attributes and characteristics of a forested
/// area, including basic information such as landowner ID, name, and acreage;
/// site characteristics like elevation, aspect, and slope; vegetative conditions
/// such as cover type, stand structure, and density; damages from insects, diseases,
/// invasives, and wildlife; mistletoe presence and its uniformity; as well as free
/// response fields for road health, water health, fire risk, and other issues.
class Area extends ChangeNotifier {
  /// Create a model of an area.
  ///
  /// When [id] is left null, it is assumed the the model represents an area
  /// that is not yet stored in the database.
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

  /// Named constructor to convert a database record (which is in the form of a
  /// [Map]) to an instance of of the model class.
  Area.fromMap(Map dbRecord)
      : this(
            id: dbRecord[DAOArea.colID],

            // Basic Information
            landownerID: dbRecord[DAOArea.colLandownerID],
            name: dbRecord[DAOArea.colName],
            acres: dbRecord[DAOArea.colAcres],
            goals: dbRecord[DAOArea.colGoals],

            // Site Characteristics
            elevation: dbRecord[DAOArea.colElevation],
            aspect: _convertDBToEnum(
                dbRecord[DAOArea.colAspect], Direction.values, Direction.na),
            slopePercentage: dbRecord[DAOArea.colSlopePercentage],
            slopePosition: _convertDBToEnum(
              dbRecord[DAOArea.colSlopePosition],
              SlopePosition.values,
              SlopePosition.na,
            ),
            soilInfo: dbRecord[DAOArea.colSoilInfo],

            // Vegetative Conditions
            coverType: _convertDBToEnum(
              dbRecord[DAOArea.colCoverType],
              CoverType.values,
              CoverType.na,
            ),
            standStructure: _convertDBToEnum(
              dbRecord[DAOArea.colStandStructure],
              StandStructure.values,
              StandStructure.na,
            ),
            overstoryDensity: _convertDBToEnum(
              dbRecord[DAOArea.colOverstoryDensity],
              StandDensity.values,
              StandDensity.na,
            ),
            overstorySpeciesComposition:
                dbRecord[DAOArea.colOverstorySpeciesComposition],
            understoryDensity: _convertDBToEnum(
              dbRecord[DAOArea.colUnderstoryDensity],
              StandDensity.values,
              StandDensity.na,
            ),
            understorySpeciesComposition:
                dbRecord[DAOArea.colUnderstorySpeciesComposition],
            standHistory: dbRecord[DAOArea.colStandHistory],

            // Damages
            insects: dbRecord[DAOArea.colInsects],
            diseases: dbRecord[DAOArea.colDiseases],
            invasives: dbRecord[DAOArea.colInvasives],
            wildlifeDamage: dbRecord[DAOArea.colWildlifeDamage],

            // Mistletoe
            mistletoeUniformity: _convertDBToEnum(
              dbRecord[DAOArea.colMistletoeUniformity],
              MistletoeUniformity.values,
              MistletoeUniformity.na,
            ),
            mistletoeLocation: dbRecord[DAOArea.colMistletoeLocation],
            hawksworth: _convertDBToEnum(
              dbRecord[DAOArea.colHawksworth],
              Hawksworth.values,
              Hawksworth.na,
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
  /// Assumes each [enum] has a [na] member representing an "N/A" option.
  /// Should only be used in [.fromMap()]. [databaseValue] will be the string
  /// returned from a given record for one of the columns that uses
  /// [enum]s. [enumValues] is said [enum] class's [.values] member
  /// (e.g. [/lib/enums/hawksworth.dart]).
  static dynamic _convertDBToEnum(
      String? databaseValue, dynamic enumValues, dynamic na) {
    if (databaseValue == null) return na;
    for (var enumValue in enumValues) {
      if (databaseValue == enumValue.label) return enumValue;
    }
    return na;
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
  Direction _aspect;
  int? _slopePercentage;
  SlopePosition _slopePosition;
  String? _soilInfo;

  // Vegetative Conditions
  CoverType _coverType;
  StandStructure _standStructure;
  StandDensity _overstoryDensity;
  int? _overstorySpeciesComposition;
  StandDensity _understoryDensity;
  int? _understorySpeciesComposition;
  String? _standHistory;

  // Damages
  String? _insects;
  String? _diseases;
  String? _invasives;
  String? _wildlifeDamage;

  // Mistletoe
  MistletoeUniformity _mistletoeUniformity;
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

  // Methods For Preparing For Area For Use In Form ////////////////////////////
  // Don't use above individual setters because it would be wasteful to call
  // notify listeners repeatedly when we really only need to call it once.

  void clearForNewForm() {
    _id = null;

    // Individual Form Screens
    _setBasicInfo();
    _setSiteCharacteristics();
    _setVegetativeConditions();
    _setDamages();
    _setMistletoe();
    _setFreeResponses();

    notifyListeners();
  }

  void setFromOther(Area that) {
    _id = that.id;

    _setBasicInfo(
      landownerID: that._landownerID,
      name: that._name,
      acres: that._acres,
      goals: that._goals,
    );

    _setSiteCharacteristics(
      elevation: that._elevation,
      aspect: that._aspect,
      slopePercentage: that._slopePercentage,
      slopePosition: that._slopePosition,
      soilInfo: that._soilInfo,
    );

    _setVegetativeConditions(
      coverType: that._coverType,
      standStructure: that._standStructure,
      overstoryDensity: that._overstoryDensity,
      overstorySpeciesComposition: that._overstorySpeciesComposition,
      understoryDensity: that._understoryDensity,
      understorySpeciesComposition: that._understorySpeciesComposition,
      standHistory: that._standHistory,
    );

    _setDamages(
      insects: that._insects,
      diseases: that._diseases,
      invasives: that._invasives,
      wildlifeDamage: that._wildlifeDamage,
    );

    _setMistletoe(
      mistletoeUniformity: that._mistletoeUniformity,
      mistletoeLocation: that._mistletoeLocation,
      hawksworth: that._hawksworth,
      mistletoeTreeSpecies: that._mistletoeTreeSpecies,
    );

    _setFreeResponses(
      roadHealth: that._roadHealth,
      waterHealth: that._waterHealth,
      fireRisk: that._fireRisk,
      otherIssues: that._otherIssues,
      diagnosis: that._diagnosis,
    );

    notifyListeners();
  }

  void _setBasicInfo(
      {int? landownerID, String? name, double? acres, String? goals}) {
    _landownerID = landownerID;
    _name = name;
    _acres = acres;
    _goals = goals;
  }

  void _setSiteCharacteristics({
    int? elevation,
    Direction aspect = Direction.na,
    int? slopePercentage,
    SlopePosition slopePosition = SlopePosition.na,
    String? soilInfo,
  }) {
    _elevation = elevation;
    _aspect = aspect;
    _slopePercentage = slopePercentage;
    _slopePosition = slopePosition;
    _soilInfo = soilInfo;
  }

  void _setVegetativeConditions({
    CoverType coverType = CoverType.na,
    StandStructure standStructure = StandStructure.na,
    StandDensity overstoryDensity = StandDensity.na,
    int? overstorySpeciesComposition,
    StandDensity understoryDensity = StandDensity.na,
    int? understorySpeciesComposition,
    String? standHistory,
  }) {
    _coverType = coverType;
    _standStructure = standStructure;
    _overstoryDensity = overstoryDensity;
    _overstorySpeciesComposition = overstorySpeciesComposition;
    _understoryDensity = understoryDensity;
    _understorySpeciesComposition = understorySpeciesComposition;
    _standHistory = standHistory;
  }

  void _setDamages({
    String? insects,
    String? diseases,
    String? invasives,
    String? wildlifeDamage,
  }) {
    _insects = insects;
    _diseases = diseases;
    _invasives = invasives;
    _wildlifeDamage = wildlifeDamage;
  }

  void _setMistletoe({
    MistletoeUniformity mistletoeUniformity = MistletoeUniformity.na,
    String? mistletoeLocation,
    Hawksworth hawksworth = Hawksworth.na,
    String? mistletoeTreeSpecies,
  }) {
    _mistletoeUniformity = mistletoeUniformity;
    _mistletoeLocation = mistletoeLocation;
    _hawksworth = hawksworth;
    _mistletoeTreeSpecies = mistletoeTreeSpecies;
  }

  void _setFreeResponses({
    String? roadHealth,
    String? waterHealth,
    String? fireRisk,
    String? otherIssues,
    String? diagnosis,
  }) {
    _roadHealth = roadHealth;
    _waterHealth = waterHealth;
    _fireRisk = fireRisk;
    _otherIssues = otherIssues;
    _diagnosis = diagnosis;
  }

  // Debugging Helpers /////////////////////////////////////////////////////////
  @override
  String toString() {
    // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
    return "\n_id: $_id" +
        // Basic Information
        "\n_landownerID: $_landownerID" +
        "\n_name: $_name" +
        "\n_acres: $_acres" +
        "\n_goals: $_goals" +

        // Site Characteristics
        "\n_elevation: $_elevation" +
        "\n_aspect: $_aspect" +
        "\n_slopePercentage: $_slopePercentage" +
        "\n_slopePosition: $_slopePosition" +
        "\n_soilInfo: $_soilInfo" +

        // Vegetative Conditions
        "\n_coverType: $_coverType" +
        "\n_standStructure: $_standStructure" +
        "\n_overstoryDensity: $_overstoryDensity" +
        "\n_overstorySpeciesComposition: $_overstorySpeciesComposition" +
        "\n_understoryDensity: $_understoryDensity" +
        "\n_understorySpeciesComposition: $_understorySpeciesComposition" +
        "\n_standHistory: $_standHistory" +

        // Damages
        "\n_insects: $_insects" +
        "\n_diseases: $_diseases" +
        "\n_invasives: $_invasives" +
        "\n_wildlifeDamage: $_wildlifeDamage" +

        // Mistletoe
        "\n_mistletoeUniformity: $_mistletoeUniformity" +
        "\n_mistletoeLocation: $_mistletoeLocation" +
        "\n_hawksworth: $_hawksworth" +
        "\n_mistletoeTreeSpecies: $_mistletoeTreeSpecies" +

        // Free responses
        "\n_roadHealth: $_roadHealth" +
        "\n_waterHealth: $_waterHealth" +
        "\n_fireRisk: $_fireRisk" +
        "\n_otherIssues: $_otherIssues" +
        "\n_diagnosis: $_diagnosis";
  }
}
