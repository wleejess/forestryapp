import 'package:flutter/material.dart';

class FireRisk extends ChangeNotifier {
  String _fireInfo = '';

  String get fireInfo => _fireInfo;

  set fireInfo(String value) {
    _fireInfo = value;
    notifyListeners();
  }
}
