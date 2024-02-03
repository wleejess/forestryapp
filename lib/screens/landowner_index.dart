import "package:flutter/material.dart";
import "package:forestryapp/components/fab_creation.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/navigable_list_tile.dart";
import "package:forestryapp/screens/landowner_review.dart";

/// Screen for showing saved landowners from the navigation drawer.
///
/// Can view existing landowners or create new landowners from this screen.
class LandownerIndex extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final _title = "Landowners";

  /// Dummy data to be replaced by model later.
  static const _landowners = [
    {
      "name": "Amy Adams",
      "email": "a@gmail.com",
      "streetAddress": "1234 Alpha Street",
      "city": "Acton",
      "state": "AL",
      "zipCode": "1",
    },
    {
      "name": "Bob Bancroft",
      "email": "b@gmail.com",
      "streetAddress": "1234 Beta Street",
      "city": "Burne",
      "state": "AZ",
      "zipCode": "2",
    },
    {
      "name": "Chet Chapman",
      "email": "c@gmail.com",
      "streetAddress": "1234 Gamma Street",
      "city": "Chico",
      "state": "CA",
      "zipCode": "3",
    },
    {
      "name": "Donna Dawson",
      "email": "d@gmail.com",
      "streetAddress": "1234 Delta Street",
      "city": "Davis",
      "state": "DE",
      "zipCode": "4",
    },
    {
      "name": "Edgar Edmonds",
      "email": "e@gmail.com",
      "streetAddress": "1234 Epsilon Street",
      "city": "Empire",
      "state": "OR",
      "zipCode": "5",
    },
  ];

  /// Dummy data to be replaced by model later. Assmued to have same length as
  /// `_landowners`.
  static const _areasByLandowner = [
    [
      "Ash Wood",
      "Birch Grove",
      "Chestnut Creek",
      "Proin neque massa, cursus ut, gravida ut, lobortis eget, lacus.",
      "Nulla facilisis, risus a rhoncus fermentum, tellus tellus lacinia purus, et dictum nunc justo sit amet elit.",
      "Nullam rutrum.",
      "Pellentesque tristique imperdiet tortor.",
      "Nullam rutrum.",
      "Aliquam posuere.",
      "Phasellus at dui in ligula mollis ultricies.",
      "Nunc rutrum turpis sed pede.",
      "Nullam tempus.",
      "Pellentesque dapibus suscipit ligula.",
      "Nunc aliquet, augue nec adipiscing interdum, lacus tellus malesuada massa, quis varius mi purus non odio.",
    ],
    ["Ash Wood", "Birch Grove", "Chestnut Creek"],
    <String>[],
    <String>[],
    <String>[],
  ];

  // Constructors //////////////////////////////////////////////////////////////
  const LandownerIndex({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: ListView.builder(
        itemCount: _landowners.length,
        itemBuilder: _landownerIndexListTileBuilder,
      ),
      fab: FABCreation(icon: Icons.person, onPressed: () {}),
    );
  }

  Widget _landownerIndexListTileBuilder(BuildContext context, int i) {
    final String name = _landowners[i]["name"] ?? "missing name";
    assert(_landowners.length == _areasByLandowner.length);
    return NavigableListTile(
      // WARNING: This is hacky and only here for the sake of passing dummy data
      // to the Landowner Review screen. Replace with something more robust when
      // models class for Landowner is implemented.
      titleText: name,
      routeBuilder: (context) => LandownerReview(
        name: name,
        email: _landowners[i]["email"] ?? "missing email",
        streetAddress: _landowners[i]["streetAddress"] ?? "missing address",
        city: _landowners[i]["city"] ?? "missing city",
        state: _landowners[i]["state"] ?? "missing state",
        zipCode: _landowners[i]["zipCode"] ?? "missing zip code",
        areas: _areasByLandowner[i],
      ),
    );
  }
}
