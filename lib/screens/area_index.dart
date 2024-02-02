import "package:flutter/material.dart";
import "package:forestryapp/components/fab_creation.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/navigable_list_tile.dart";
import "package:forestryapp/screens/area_review.dart";

/// Screen for showing saved areas from the navigation drawer.
///
/// Can view existing areas or create new areas from this screen.
class AreaIndex extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final _title = "Areas";
  final List<String> _areas = [
    "Ash Woodlands",
    "Birch Grove",
    "Charred Forest",
    "Darkwood",
    "Eagle Copse"
  ]; // Dummy data to be replaced by model later.

  // Constructors //////////////////////////////////////////////////////////////
  AreaIndex({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: ListView.builder(
          itemCount: _areas.length, itemBuilder: _areaIndexListTileBuilder),
      fab: FABCreation(icon: Icons.forest, onPressed: () {}),
    );
  }

  Widget _areaIndexListTileBuilder(BuildContext context, int i) {
    return NavigableListTile(
        titleText: _areas[i],
        routeBuilder: (context) => AreaReview(name: _areas[i]));
  }
}
