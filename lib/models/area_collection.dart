import 'package:flutter/material.dart';
import 'package:forestryapp/database/dao_area.dart';
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

  /// Call this to make sure always have the most recent areas on hand.
  ///
  /// Make sure to also call with [listen: false] if calling from
  /// [Provider.of<AreaCollection>] when needing to force parents to rebuild
  /// https://stackoverflow.com/a/58584363.
  Future<void> refetch() async {
    areas = await DAOArea.fetchFromDatabase();
  }
}
