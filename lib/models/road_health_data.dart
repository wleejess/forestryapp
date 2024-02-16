import 'package:flutter/material.dart';

class RoadHealthDataModel extends ChangeNotifier {
  String _roadInfo = '';

  String get roadInfo => _roadInfo;

  set roadInfo(String value) {
    _roadInfo = value;
    notifyListeners();
  }
}
