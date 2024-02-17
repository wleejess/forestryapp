import "package:flutter/material.dart";
import "package:forestryapp/components/fab_creation.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/navigable_list_tile.dart";
import "package:forestryapp/database/dao_landowner.dart";
import "package:forestryapp/models/landowner.dart";
import "package:forestryapp/screens/landowner_review.dart";

/// Screen for showing saved landowners from the navigation drawer.
///
/// Can view existing landowners or create new landowners from this screen.
class LandownerIndex extends StatefulWidget {
  static const _title = "Landowners";

  // Constructors //////////////////////////////////////////////////////////////
  const LandownerIndex({super.key});

  @override
  State<LandownerIndex> createState() => _LandownerIndexState();
}

class _LandownerIndexState extends State<LandownerIndex> {
  late List<Landowner> _landowners = [];

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    // `initState()` itself can't be `async` but it can call `async` functions.
    _readLandowners();
  }

  void _readLandowners() async {
    _landowners = await DAOLandowner.fetchFromDatabase();
    setState(() {});
  }

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: LandownerIndex._title,
      body: ListView.builder(
        itemCount: _landowners.length,
        itemBuilder: _landownerIndexListTileBuilder,
      ),
      fab: FABCreation(icon: Icons.person, onPressed: () {}),
    );
  }

  Widget _landownerIndexListTileBuilder(BuildContext context, int i) {
    final String name = _landowners[i].name;
    return NavigableListTile(
      titleText: name,
      routeBuilder: (context) => LandownerReview(
        name: name,
        email: _landowners[i].email,
        streetAddress: _landowners[i].address,
        city: _landowners[i].city,
        state: (_landowners[i].state == null) ? '': _landowners[i].state!.label,
        zipCode: _landowners[i].zip,
        // TODO: The areas should actually be queried from `LandownerReview` and
        // this parameter should be removed entirely.
        areas: const [],
      ),
    );
  }
}
