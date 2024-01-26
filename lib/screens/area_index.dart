import "package:flutter/material.dart";
import "package:forestryapp/components/fab_creation.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/model_list_view.dart";

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
      body: ModelListView(modelInstances: _areas),
      fab: FABCreation(icon: Icons.forest, onPressed: () {}),
    );
  }
}
