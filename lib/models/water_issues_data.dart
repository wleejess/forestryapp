import 'package:flutter/material.dart';

class WaterIssuesDataModel extends ChangeNotifier {
  String _waterInfo = '';

  String get waterInfo => _waterInfo;

  set waterInfo(String value) {
    _waterInfo = value;
    notifyListeners();
  }
}
