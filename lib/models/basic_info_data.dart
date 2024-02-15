import 'package:flutter/material.dart';

class BasicInfoDataModel extends ChangeNotifier {
  String _name = '';
  double? _acres;
  int _landownerId = 0;
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

  int get landownerId => _landownerId;

  set landowerId(int value) {
    _landownerId = value;
    notifyListeners();
  }

  String? get goals => _goals;

  set goals(String? value) {
    _goals = value;
    notifyListeners();
  }

}
