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
  // Public Fields //////////////////////////////////////////////////////////////
  late String landowner;
  late String name;
  late String acres;
  late String goals;
  late int elevation;
  late Direction direction;
  late String slopePercentage;
  late SlopePosition slopePosition;
  late String soilInfo;
  late CoverType coverType;
  late StandStructure standStructure;
  late StandDensity overstoryDensity;
  late String overstorySpeciesComposition;
  late StandDensity understoryDensity;
  late String understorySpeciesComposition;
  late String standHistory;
  late String insects;
  late String diseases;
  late String invasives;
  late String wildlifeDamage;
  late MistletoeUniformity mistletoeUniformity;
  late String mistletoeLocation;
  late Hawksworth hawksworth;
  late String mistletoeTreeSpecies;
  late String roadHealth;
  late String waterHealth;
  late String fireRisk;
  late String otherIssues;
  late String diagnosis;

  // Constructor ///////////////////////////////////////////////////////////////
  // No parameters. Set attribute values publicly.
  DTOArea();

  // Methods //////////////////////////////////////////////////////////////////
}
