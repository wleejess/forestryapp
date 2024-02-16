import 'package:flutter/material.dart';
import 'package:forestryapp/enums/hawksworth.dart';
import 'package:forestryapp/enums/mistletoe_uniformity.dart';

class Mistletoe extends ChangeNotifier {
  MistletoeUniformity _uniformity = MistletoeUniformity.uniform;
  Hawksworth _hawksworth = Hawksworth.none;
  String? _location;
  String? _treeSpecies;

  MistletoeUniformity get uniformity => _uniformity;

  set uniformity(MistletoeUniformity value) {
    _uniformity = value;
    notifyListeners();
  }

  Hawksworth get hawksworth => _hawksworth;

  set hawksworth(Hawksworth value) {
    _hawksworth = value;
    notifyListeners();
  }

  String? get location => _location;

  set location(String? value) {
    _location = value;
    notifyListeners();
  }

  String? get treeSpecies => _treeSpecies;

  set treeSpecies(String? value) {
    _treeSpecies = value;
    notifyListeners();
  }
}
