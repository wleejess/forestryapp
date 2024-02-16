import 'package:flutter/material.dart';

class OtherIssuesDataModel extends ChangeNotifier {
  String _otherIssues = '';

  String get otherIssues => _otherIssues;

  set otherIssues(String value) {
    _otherIssues = value;
    notifyListeners();
  }
}
