import "package:flutter/material.dart";
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

  Widget _areaIndexListTileBuilder(BuildContext context, int i, List<Area> areas) {
    return NavigableListTile(
      titleText: (areas[i].name)!,
      routeBuilder: (context) => AreaReview(
        name: (areas[i].name)!,
         // TODO: Query the landowner on next page
        landowner: (areas[i].landownerID == null) ? null : areas[i].landownerID.toString(),
        acres: (areas[i].acres == null) ? null : areas[i].acres.toString(),
        goals: areas[i].goals,
        elevation: (areas[i].elevation == null) ? null : areas[i].elevation.toString(),
        aspect: areas[i].aspect.label,
        slopePercentage: (areas[i].slopePercentage == null) ? null : areas[i].slopePercentage.toString(),
        slopePosition: areas[i].slopePosition.label,
        soilInfo: areas[i].soilInfo,
        coverType: areas[i].coverType.label,
        standStructure: areas[i].standStructure.label,
        overstoryDensity: areas[i].overstoryDensity.label,
        overstorySpeciesComposition: (areas[i].overstorySpeciesComposition == null) ? null : areas[i].overstorySpeciesComposition.toString(),
        understoryDensity: areas[i].understoryDensity.label,
        understorySpeciesComposition: (areas[i].understorySpeciesComposition == null) ? null : areas[i].understorySpeciesComposition.toString(),
        siteHistory: areas[i].standHistory,
        insects: areas[i].insects,
        diseases: areas[i].diseases,
        ivasives: areas[i].invasives,
        wildlifeDamage: areas[i].wildlifeDamage,
        mistletoeUniformity: areas[i].mistletoeUniformity.label,
        mistletoeLocation: areas[i].mistletoeLocation,
        hawksworth: areas[i].hawksworth.label,
        mistletoeTreeSpecies: areas[i].mistletoeTreeSpecies,
        roadHealth: areas[i].roadHealth,
        waterHealth: areas[i].waterHealth,
        fireRisk: areas[i].fireRisk,
        otherIssues: areas[i].otherIssues,
        diagnosis: areas[i].diagnosis,
      ),
    );
  }
}
