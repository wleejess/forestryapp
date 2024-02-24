import 'package:flutter/material.dart';
import 'package:forestryapp/database/dao_landowner.dart';
import 'package:forestryapp/models/landowner.dart';

class LandownerCollection extends ChangeNotifier {
  List<Landowner> _landowners;

  LandownerCollection(List<Landowner> landowners) : _landowners = landowners;

  List<Landowner> get landowners => _landowners;

  set landowners(List<Landowner> newLandowners) {
    _landowners = newLandowners;
    notifyListeners();
  }

  /// Call this to make sure always have the most recent landowners on hand.
  ///
  /// Make sure to also call with [listen: false] if calling from
  /// [Provider.of<LandownerCollection>] when needing to force parents to rebuild
  /// https://stackoverflow.com/a/58584363.
  Future<void> refetch() async {
    landowners = await DAOLandowner.fetchFromDatabase();
  }

  Landowner? getLandownerByID(int id) {
    final matches =
        _landowners.where((landowner) => landowner.id == id).toList();

    return (matches.isNotEmpty) ? matches[0] : null;
  }
}
