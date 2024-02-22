import 'package:flutter/material.dart';
import 'package:forestryapp/models/landowner.dart';

class LandownerCollection extends ChangeNotifier {
  List<Landowner> _landowners;

  LandownerCollection(List<Landowner> landowners) : _landowners = landowners;

  List<Landowner> get landowners => _landowners;

  set landowners(List<Landowner> newLandowners) {
    _landowners = newLandowners;
    notifyListeners();
  }

  Landowner? getLandownerByID(int id) {
    final matches =
        _landowners.where((landowner) => landowner.id == id).toList();

    return (matches.isNotEmpty) ? matches[0] : null;
  }
}
