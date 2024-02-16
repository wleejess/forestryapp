import 'package:flutter/material.dart';

class FireRiskDataModel extends ChangeNotifier {
  String _fireInfo = '';

  String get fireInfo => _fireInfo;

  set fireInfo(String value) {
    _fireInfo = value;
    notifyListeners();
  }
}
