import 'package:flutter/material.dart';

class UnsavedChangesNotifier extends ChangeNotifier {
  bool _unsavedChanges = false;

  bool get unsavedChanges => _unsavedChanges;

  void setUnsavedChanges(bool value) {
    _unsavedChanges = value;
    notifyListeners();
  }
}
