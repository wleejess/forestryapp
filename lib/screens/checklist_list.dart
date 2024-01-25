import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/model_list_view.dart";

/// Screen for showing saved checklists from the navigation drawer.
///
/// Can view existing checklists or create new checklists from this screen.
class ChecklistList extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final _title = "Landowners"; // Public for the sake of navigation later.
  final List<String> checklists = [
    "Ash Woodlands",
    "Birch Grove",
    "Charred Forest",
    "Darkwood",
    "Eagle Copse"
  ]; // Dummy data to be replaced by model later.

  // Constructors //////////////////////////////////////////////////////////////
  ChecklistList({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: ModelListView(modelInstances: checklists),
    );
  }
}
