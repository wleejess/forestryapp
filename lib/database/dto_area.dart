// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:forestryapp/enums/cover_type.dart';
import 'package:forestryapp/enums/direction.dart';
import 'package:forestryapp/enums/hawksworth.dart';
import 'package:forestryapp/enums/mistletoe_uniformity.dart';
import 'package:forestryapp/enums/slope_position.dart';
import 'package:forestryapp/enums/stand_density.dart';
import 'package:forestryapp/enums/stand_structure.dart';


/// Intermediate class to act as a bucket for collecting model data to send off
/// to DB.
///
/// Not responsible for any behavior only state.
class DTOArea {
  /// Only needed if updating an area (DB will auto generate an id on creation).
  late int id;

  // Public Fields //////////////////////////////////////////////////////////////
  late int landownerID;
  late String name;
  double? acres;
  String? goals;
  int? elevation;
  late Direction direction;
  int? slopePercentage;
  late SlopePosition slopePosition;
  String? soilInfo;
  late CoverType coverType;
  late StandStructure standStructure;
  late StandDensity overstoryDensity;
  int? overstorySpeciesComposition;
  late StandDensity understoryDensity;
  int? understorySpeciesComposition;
  String? standHistory;
  String? insects;
  String? diseases;
  String? invasives;
  String? wildlifeDamage;
  late MistletoeUniformity mistletoeUniformity;
  String? mistletoeLocation;
  late Hawksworth hawksworth;
  String? mistletoeTreeSpecies;
  String? roadHealth;
  String? waterHealth;
  String? fireRisk;
  String? otherIssues;
  String? diagnosis;

  // Constructor ///////////////////////////////////////////////////////////////
  // No parameters. Set attribute values publicly.
  DTOArea();

  // Methods //////////////////////////////////////////////////////////////////
}
