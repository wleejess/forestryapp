import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

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
        body: ListView.builder(
          itemBuilder: _buildLandownerBuilder,
          itemCount: landowners.length,
        ));
  }

  ListTile _buildLandownerBuilder(BuildContext context, int i) {
    return ListTile(
      title: Text(landowners[i], style: const TextStyle(fontSize: 36)),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
