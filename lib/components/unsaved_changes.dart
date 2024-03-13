import 'package:flutter/material.dart';

/// A ChangeNotifier that notifies listeners of unsaved changes.
class UnsavedChangesNotifier extends ChangeNotifier {
  /// Indicates whether there are unsaved changes.
  bool _unsavedChanges = false;

  /// Getter for the [_unsavedChanges] property.
  bool get unsavedChanges => _unsavedChanges;

  /// Sets the value of [_unsavedChanges] and notifies listeners.
  void setUnsavedChanges(bool value) {
    _unsavedChanges = value;
    notifyListeners();
  }
}
