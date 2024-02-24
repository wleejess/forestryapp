import 'package:flutter/material.dart';
import 'package:forestryapp/database/dao_landowner.dart';
import 'package:forestryapp/models/landowner.dart';

/// Listenable to force rebuild on screens whenever refetching [Landowner]
/// records.
class LandownerCollection extends ChangeNotifier {
  // Variables To Provide //////////////////////////////////////////////////////
  List<Landowner> _landowners;
  Landowner? _landownerOfAreaBeingReviewed;

  // Constructor ///////////////////////////////////////////////////////////////

  LandownerCollection(List<Landowner> landowners) : _landowners = landowners;

  List<Landowner> get landowners => _landowners;

  set landowners(List<Landowner> newLandowners) {
    _landowners = newLandowners;
    notifyListeners();
  }

  Landowner? get landownerOfReviewedArea => _landownerOfAreaBeingReviewed;

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

  // Relationship Queries //////////////////////////////////////////////////////

  Future<void> setLandownerOfAreaBeingReviewed(int areaID) async {
    Landowner? landowner = await DAOLandowner.readLandownerFromArea(areaID);
    refetch();
    _landownerOfAreaBeingReviewed = landowner;
  }
}
