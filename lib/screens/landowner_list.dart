import "package:flutter/material.dart";
import "package:forestryapp/components/fab_creation.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/model_list_view.dart";

/// Screen for showing saved landowners from the navigation drawer.
///
/// Can view existing landowners or create new landowners from this screen.
class LandownerList extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final _title = "Landowners"; // Public for the sake of navigation later.
  final List<String> landowners = [
    "Amy Adams",
    "Bob Bancroft",
    "Chet Chapman",
    "Donna Dawson",
    "Edgar Edmonds"
  ]; // Dummy data to be replaced by model later.

  // Constructors //////////////////////////////////////////////////////////////
  LandownerList({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: ModelListView(modelInstances: landowners),
      fab: FABCreation(icon: Icons.person, onPressed: () {}),
    );
  }
}
