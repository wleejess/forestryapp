import "package:flutter/material.dart";
import "package:forestryapp/components/db_listenable_builder.dart";
import "package:forestryapp/components/error_scaffold.dart";
import "package:forestryapp/components/fab_creation.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/navigable_list_tile.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/screens/area_review.dart";
import "package:forestryapp/screens/basic_information_form.dart";
import "package:provider/provider.dart";

/// Screen for showing saved areas from the navigation drawer.
///
/// Can view existing areas or create new areas from this screen.
class AreaIndex extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _errorTitle = "Area Not Found";
  static const _errorBody = "Could not find area with id: ";

  // Instance variables ////////////////////////////////////////////////////////
  final _title = "Areas";

  // Constructors //////////////////////////////////////////////////////////////
  const AreaIndex({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final areasListenable = Provider.of<AreaCollection>(context);

    return ForestryScaffold(
      title: _title,
      body: DBListenableBuilder(
        builder: (BuildContext _, Widget? __) =>
            _buildListViewOfAllAreasFromDB(areasListenable.areas),
      ),
      fab: FABCreation(icon: Icons.forest, onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BasicInformationForm()),
        );
      }),
    );
  }

  ListView _buildListViewOfAllAreasFromDB(List<Area> areas) {
    return ListView.builder(
      itemCount: areas.length,
      itemBuilder: (BuildContext context, int i) =>
          _areaIndexListTileBuilder(context, i, areas),
    );
  }

  Widget _areaIndexListTileBuilder(
    BuildContext context,
    int i,
    List<Area> areas,
  ) {
    return NavigableListTile(
      titleText: (areas[i].name)!,
      onTap: () async => await _tapOnArea(context, areas[i]),
    );
  }

  Future<void> _tapOnArea(BuildContext context, Area area) async {
    final id = area.id;

    final Widget destination;

    if (id == null) {
      destination =
          ErrorScaffold(title: _errorTitle, bodyText: "$_errorBody$id");
    } else {
      // Fetch landowner of given area.
      await Provider.of<LandownerCollection>(context, listen: false)
          .setLandownerOfAreaBeingReviewed(id);
      if (!context.mounted) return;
      destination = AreaReview(id);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}
