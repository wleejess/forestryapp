import 'package:flutter/material.dart';
import 'package:forestryapp/models/landowner.dart';

class BasicInformation extends ChangeNotifier {
  String _name = '';
  double? _acres;
  Landowner? _landowner;
  String? _goals;

  String get name => _name;

  set name(String value) {
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
}
