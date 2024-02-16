import 'package:flutter/material.dart';
import 'package:forestryapp/enums/stand_structure.dart';
import 'package:forestryapp/enums/cover_type.dart';
import 'package:forestryapp/enums/stand_density.dart';

class VegConditionsDataModel extends ChangeNotifier {
  CoverType _coverType = CoverType.forest;
  StandStructure _standStructure = StandStructure.evenAged;
  StandDensity _overstoryDensity = StandDensity.low;
  String _overstorySlope = '';
  StandDensity _understoryDensity = StandDensity.low;
  String _understorySlope = '';
  String _standHistory = '';

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

  String get overstorySlope => _overstorySlope;

  set overstorySlope(String value) {
    _overstorySlope = value;
    notifyListeners();
  }

  StandDensity get understoryDensity => _understoryDensity;

  set understoryDensity(StandDensity value) {
    _understoryDensity = value;
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
}
