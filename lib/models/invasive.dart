import 'package:flutter/material.dart';

class Invasive extends ChangeNotifier {
  /// List of invasive species
  String? _invasiveSpecies;
  /// Description of wildlife damage or issues
  String? _wildlifeDamage;

  String? get invasiveSpecies => _invasiveSpecies;

  set invasiveSpecies(String? value) {
    _invasiveSpecies = value;
    notifyListeners();
  }

  String? get wildlifeDamage => _wildlifeDamage;

  set wildlifeDamage(String? value) {
    _wildlifeDamage = value;
    notifyListeners();
  }
}
