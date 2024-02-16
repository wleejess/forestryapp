import 'package:flutter/material.dart';

class Insects extends ChangeNotifier {
  /// Description of insects in the area
  String? _insects;
  /// Description of diseases in the area
  String? _diseases;

  String? get insects => _insects;

  set insects(String? value) {
    _insects = value;
    notifyListeners();
  }

  String? get diseases => _diseases;

  set diseases(String? value) {
    _diseases = value;
    notifyListeners();
  }
}
