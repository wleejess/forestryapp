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
  final _areas = [
    {
      "name": "Hudson Foreset",
      "landowner": "Bob Anderson",
      "acres": "50",
      "goals": "Wildfier mitigation",
      "elevation": "6500",
      "aspect": "SW",
      "slopePercentage": "8",
      "slopePosition": "Ridgetop",
      "soilInfo": null,
      "coverType": "Pine-hardwood",
      "standStructure": "Even-Aged",
      "overstoryDensity": "High",
      "overstorySpeciesComposition": "80",
      "understoryDensity": "Low",
      "understorySpeciesComposition": "20",
      "siteHistory":
          "Aliquam erat volutpat. Nunc eleifend leo vitae magna. In id erat non orci commodo lobortis. Proin neque massa, cursus ut, gravida ut, lobortis eget, lacus. Sed diam. Praesent fermentum tempor tellus. Nullam tempus. Mauris ac felis vel velit tristique imperdiet. Donec at pede. Etiam vel neque nec dui dignissim bibendum. Vivamus id enim. Phasellus neque orci, porta a, aliquet quis, semper a, massa. Phasellus purus. Pellentesque tristique imperdiet tortor. Nam euismod tellus id erat.",
      "insects":
          "Western Pine Beetle. Flat-headed Wood Borer. Sequoia Pitch Moth.",
      "diseases": "Black Stain. Elytroderma disease (of ponderosa pine).",
      "ivasives": "Gorse. Holly.",
      "wildlifeDamage":
          "Nullam eu ante vel est convallis dignissim. Fusce suscipit, wisi nec facilisis facilisis, est dui fermentum leo, quis tempor ligula erat quis odio. Nunc porta vulputate tellus. Nunc rutrum turpis sed pede. Sed bibendum. Aliquam posuere. Nunc aliquet, augue nec adipiscing interdum, lacus tellus malesuada massa, quis varius mi purus non odio. Pellentesque condimentum, magna ut suscipit hendrerit, ipsum augue ornare nulla, non luctus diam neque sit amet urna. Curabitur vulputate vestibulum lorem. Fusce sagittis, libero non molestie mollis, magna orci ultrices dolor, at vulputate neque nulla lacinia eros. Sed id ligula quis est convallis tempor. Curabitur lacinia pulvinar nibh. Nam a sapien.",
      "mistletoeUniformity": "Uniform",
      "mistletoeLocation": null,
      "hawksworth": "2",
      "mistletoeTreeSpecies": "Douglas-fir mistletoe. Western larch mistletoe.",
      "roadHealth":
          "Aliquam erat volutpat. Nunc eleifend leo vitae magna. In id erat non orci commodo lobortis. Proin neque massa, cursus ut, gravida ut, lobortis eget, lacus. Sed diam. Praesent fermentum tempor tellus. Nullam tempus. Mauris ac felis vel velit tristique imperdiet. Donec at pede. Etiam vel neque nec dui dignissim bibendum. Vivamus id enim. Phasellus neque orci, porta a, aliquet quis, semper a, massa. Phasellus purus. Pellentesque tristique imperdiet tortor. Nam euismod tellus id erat.",
      "waterHealth":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec hendrerit tempor tellus. Donec pretium posuere tellus. Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla posuere. Donec vitae dolor. Nullam tristique diam non turpis. Cras placerat accumsan nulla. Nullam rutrum. Nam vestibulum accumsan nisl.",
      "fireRisk":
          "Pellentesque dapibus suscipit ligula.  Donec posuere augue in quam.  Etiam vel tortor sodales tellus ultricies commodo.  Suspendisse potenti.  Aenean in sem ac leo mollis blandit.  Donec neque quam, dignissim in, mollis nec, sagittis eu, wisi.  Phasellus lacus.  Etiam laoreet quam sed arcu.  Phasellus at dui in ligula mollis ultricies.  Integer placerat tristique nisl.  Praesent augue.  Fusce commodo.  Vestibulum convallis, lorem a tempus semper, dui dui euismod elit, vitae placerat urna tortor vitae lacus.  Nullam libero mauris, consequat quis, varius et, dictum id, arcu.  Mauris mollis tincidunt felis.  Aliquam feugiat tellus ut neque.  Nulla facilisis, risus a rhoncus fermentum, tellus tellus lacinia purus, et dictum nunc justo sit amet elit.",
      "otherIssues":
          "Nullam eu ante vel est convallis dignissim.  Fusce suscipit, wisi nec facilisis facilisis, est dui fermentum leo, quis tempor ligula erat quis odio.  Nunc porta vulputate tellus.  Nunc rutrum turpis sed pede.  Sed bibendum.  Aliquam posuere.  Nunc aliquet, augue nec adipiscing interdum, lacus tellus malesuada massa, quis varius mi purus non odio.  Pellentesque condimentum, magna ut suscipit hendrerit, ipsum augue ornare nulla, non luctus diam neque sit amet urna.  Curabitur vulputate vestibulum lorem.  Fusce sagittis, libero non molestie mollis, magna orci ultrices dolor, at vulputate neque nulla lacinia eros.  Sed id ligula quis est convallis tempor.  Curabitur lacinia pulvinar nibh.  Nam a sapien.",
      "diagnosis":
          "Pellentesque dapibus suscipit ligula.  Donec posuere augue in quam.  Etiam vel tortor sodales tellus ultricies commodo.  Suspendisse potenti.  Aenean in sem ac leo mollis blandit.  Donec neque quam, dignissim in, mollis nec, sagittis eu, wisi.  Phasellus lacus.  Etiam laoreet quam sed arcu.  Phasellus at dui in ligula mollis ultricies.  Integer placerat tristique nisl.  Praesent augue.  Fusce commodo.  Vestibulum convallis, lorem a tempus semper, dui dui euismod elit, vitae placerat urna tortor vitae lacus.  Nullam libero mauris, consequat quis, varius et, dictum id, arcu.  Mauris mollis tincidunt felis.  Aliquam feugiat tellus ut neque.  Nulla facilisis, risus a rhoncus fermentum, tellus tellus lacinia purus, et dictum nunc justo sit amet elit.",
    },
    {"name": "Birch Grove"},
    {"name": "Charred Forest"},
    {"name": "Darkwood"},
    {"name": "Eagle Copse"}
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
      titleText: (_areas[i]['name'])!,
      routeBuilder: (context) => AreaReview(
        name: (_areas[i]['name'])!,
        landowner: _areas[i]['landowner'],
        acres: _areas[i]['acres'],
        goals: _areas[i]['goals'],
        elevation: _areas[i]['elevation'],
        aspect: _areas[i]['aspect'],
        slopePercentage: _areas[i]['slopePercentage'],
        slopePosition: _areas[i]['slopePosition'],
        soilInfo: _areas[i]['soilInfo'],
        coverType: _areas[i]['coverType'],
        standStructure: _areas[i]['standStructure'],
        overstoryDensity: _areas[i]['overstoryDensity'],
        overstorySpeciesComposition: _areas[i]['overstorySpeciesComposition'],
        understoryDensity: _areas[i]['understoryDensity'],
        understorySpeciesComposition: _areas[i]['understorySpeciesComposition'],
        siteHistory: _areas[i]['siteHistory'],
        insects: _areas[i]['insects'],
        diseases: _areas[i]['diseases'],
        ivasives: _areas[i]['ivasives'],
        wildlifeDamage: _areas[i]['wildlifeDamage'],
        mistletoeUniformity: _areas[i]['mistletoeUniformity'],
        mistletoeLocation: _areas[i]['mistletoeLocation'],
        hawksworth: _areas[i]['hawksworth'],
        mistletoeTreeSpecies: _areas[i]['mistletoeTreeSpecies'],
        roadHealth: _areas[i]['roadHealth'],
        waterHealth: _areas[i]['waterHealth'],
        fireRisk: _areas[i]['fireRisk'],
        otherIssues: _areas[i]['otherIssues'],
        diagnosis: _areas[i]['diagnosis'],
      ),
    );
  }
}
