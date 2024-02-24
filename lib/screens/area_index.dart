import "package:flutter/material.dart";
import "package:forestryapp/components/error_scaffold.dart";
import "package:forestryapp/components/fab_creation.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/navigable_list_tile.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/screens/area_review.dart";
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
      body: ListenableBuilder(
        listenable: areasListenable,
        builder: (BuildContext _, Widget? __) =>
            _buildListViewOfAllAreasFromDB(areasListenable.areas),
      ),
      fab: FABCreation(icon: Icons.forest, onPressed: () {}),
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
    int? id = areas[i].id;
    return NavigableListTile(
      titleText: (areas[i].name)!,
      routeBuilder: (context) {
        if (id == null) {
          return ErrorScaffold(title: _errorTitle, bodyText: "$_errorBody$id");
        }
        return AreaReview(id);
      },
    );
  }
}
