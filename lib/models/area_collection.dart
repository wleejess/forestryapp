import 'package:flutter/material.dart';
import 'package:forestryapp/models/area.dart';

class AreaCollection extends ChangeNotifier {
  List<Area> _areas;

  AreaCollection(List<Area> areas) : _areas = areas;

  List<Area> get areas => _areas;

  set areas(List<Area> newAreas) {
    _areas = newAreas;
    notifyListeners();
  }

  Area? getAreaByID(int id) {
    final matches = _areas.where((area) => area.id == id).toList();

    return (matches.isNotEmpty) ? matches[0] : null;
  }
}
