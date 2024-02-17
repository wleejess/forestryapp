import "package:flutter/material.dart";
import "package:forestryapp/components/fab_creation.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/navigable_list_tile.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/screens/landowner_edit.dart";
import "package:forestryapp/screens/landowner_review.dart";
import "package:provider/provider.dart";

/// Screen for showing saved landowners from the navigation drawer.
///
/// Can view existing landowners or create new landowners from this screen.
class LandownerIndex extends StatelessWidget {
  static const _title = "Landowners";

  // Constructors //////////////////////////////////////////////////////////////
  const LandownerIndex({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: LandownerIndex._title,
      body: ListenableBuilder(
        listenable: Provider.of<LandownerCollection>(context),
        builder: _buildListViewOfAllLandownersFromDB,
      ),
      fab: FABCreation(
        icon: Icons.person,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LandownerEdit()),
          );
        },
      ),
    );
  }

  ListView _buildListViewOfAllLandownersFromDB(
    BuildContext context,
    Widget? child,
  ) {
    return ListView.builder(
      itemCount: Provider.of<LandownerCollection>(context).landowners.length,
      itemBuilder: _landownerIndexListTileBuilder,
    );
  }

  Widget _landownerIndexListTileBuilder(BuildContext context, int i) {
    final landowners = Provider.of<LandownerCollection>(context).landowners;
    final String name = landowners[i].name;
    return NavigableListTile(
      titleText: name,
      routeBuilder: (context) => LandownerReview(
        landowner: landowners[i],
        // TODO: The areas should actually be queried from `LandownerReview` and
        // this parameter should be removed entirely.
        areas: const [],
      ),
    );
  }
}
