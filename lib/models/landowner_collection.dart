import 'package:flutter/material.dart';
import 'package:forestryapp/database/dao_landowner.dart';
import 'package:forestryapp/models/landowner.dart';

/// Listenable to force rebuild on screens whenever refetching [Landowner]
/// records.
class LandownerCollection extends ChangeNotifier {
  // Variables To Provide //////////////////////////////////////////////////////
  List<Landowner> _landowners;
  Landowner? _landownerOfReviewedArea;

  // Constructor ///////////////////////////////////////////////////////////////

  LandownerCollection(List<Landowner> landowners) : _landowners = landowners;

  List<Landowner> get landowners => _landowners;

  Landowner? get landownerOfReviewedArea => _landownerOfReviewedArea;

  /// Call this to make sure always have the most recent landowners on hand.
  ///
  /// Make sure to also call with [listen: false] if calling from
  /// [Provider.of<LandownerCollection>] when needing to force parents to rebuild
  /// https://stackoverflow.com/a/58584363.
  Future<void> refetch() async {
    _landowners = await DAOLandowner.fetchFromDatabase();
    if (_landownerOfReviewedArea != null) {
      _landownerOfReviewedArea = getByID(_landownerOfReviewedArea!.id);
    }
    notifyListeners();
  }

  /// Search locally cached landowner models.
  ///
  /// Find landowner given its [id]. Return null if [id] is null or if no
  /// such landowner with given [id] is found.
  ///
  /// Purpose is to minimize async code and extra calls to database which would
  /// involve another conversion from database record to model object. Assumes
  /// cache kept up to date with calls to refetch() on any database operation.
  Landowner? getByID(int? id) {
    if (id == null) return null; // No ID provided, then no landowner returned.

    final matches =
        _landowners.where((landowner) => landowner.id == id).toList();

    if (matches.isEmpty) null;

    return matches[0];
  }

  // Relationship Queries //////////////////////////////////////////////////////

  Future<void> setLandownerOfAreaBeingReviewed(int areaID) async {
    Landowner? landowner = await DAOLandowner.readLandownerFromArea(areaID);
    refetch();
    _landownerOfReviewedArea = landowner;
  }
}
