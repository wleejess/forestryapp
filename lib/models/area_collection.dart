import 'package:flutter/material.dart';
import 'package:forestryapp/database/dao_area.dart';
import 'package:forestryapp/models/area.dart';

/// Listenable to force rebuild on screens whenever refetching [Area] records.
class AreaCollection extends ChangeNotifier {
  // Variables To Provide //////////////////////////////////////////////////////
  List<Area> _areas;
  final List<Area> _areasOfReviewedLandowner = [];

  // Constructor ///////////////////////////////////////////////////////////////

  AreaCollection(List<Area> areas) : _areas = areas;

  // Getters ///////////////////////////////////////////////////////////////////
  List<Area> get areas => _areas;
  List<Area> get areasOfReviewedLandowner => _areasOfReviewedLandowner;

  //  //////////////////////////////////////////////////////////////////////////

  Area? getByID(int id) {
    final matches = _areas.where((area) => area.id == id).toList();

    return (matches.isNotEmpty) ? matches[0] : null;
  }

  /// Call this to make sure always have the most recent areas on hand.
  ///
  /// Make sure to also call with [listen: false] if calling from
  /// [Provider.of<AreaCollection>] when needing to force parents to rebuild
  /// https://stackoverflow.com/a/58584363.
  Future<void> refetch() async {
    _areas = await DAOArea.fetchFromDatabase();
    notifyListeners();
  }

  // Relatipnship Queries //////////////////////////////////////////////////////
  Future<void> setAreasOfLandownerBeingReviewed(int landownerID) async {
    _areasOfReviewedLandowner.clear();
    _areasOfReviewedLandowner
        .addAll(await DAOArea.readAreasFromLandowner(landownerID));
    await refetch();
  }
}
