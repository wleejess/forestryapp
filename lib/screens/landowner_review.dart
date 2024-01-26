import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/relative_sized_box.dart";
import "package:forestryapp/util/relative_size.dart";

class LandownerReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Landowner Review";
  static const _areasHeading = "Areas";
  static const _buttonLabelNewArea = "New Area";
  static const _buttonLabelEdit = "Edit";
  static const _buttonLabelDelete = "Delete";

  static const double _heightContactInfo = 0.15;
  static const double _heightAreasHeading = 0.04;
  static const double _heightAreas = 0.5;
  static const double _heightButton = 0.05;

  // Instance variables ////////////////////////////////////////////////////////
  // NOTE: These will be refactored into a single model class later on.
  final String _name;
  final String _email;
  final String _streetAddress;
  final String _city;
  final String _state;
  final String _zipCode;
  final List<String> _areas;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to see details on a single landowner.
  const LandownerReview({
    required String name,
    required String email,
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
    required List<String> areas,
    super.key,
  })  : _name = name,
        _email = email,
        _streetAddress = streetAddress,
        _city = city,
        _state = state,
        _zipCode = zipCode,
        _areas = areas;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: "$_title: $_name",
      body: Column(
        children: <Widget>[
          _buildContactInfo(context),
          _buildAreasHeading(context),
          _buildAreas(context),
          _buildButtonNewArea(context),
          Expanded(child: Container()),
          _buildButtonRowEditDelete(context),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return RelativeSizedBox(
      percentageHeight: _heightContactInfo,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_name, style: Theme.of(context).textTheme.headlineLarge),
            Text("Email: $_email",
                style: Theme.of(context).textTheme.headlineMedium),
            Text("Address: $_streetAddress",
                style: Theme.of(context).textTheme.headlineMedium),
            Text("$_city, $_state $_zipCode",
                style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildAreasHeading(BuildContext context) {
    return RelativeSizedBox(
      percentageHeight: _heightAreasHeading,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Text(
          _areasHeading,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  Widget _buildAreas(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: RelativeSize.computeHeight(context, _heightAreas),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _areas.length,
          itemBuilder: _buildAreaListItem,
        ),
      ),
    );
  }

  Widget _buildAreaListItem(BuildContext context, int i) {
    // Use `Card` for work around with overlapping `ListTiles`
    // https://github.com/flutter/flutter/issues/94261#issuecomment-983166280
    return Card(
      child: ListTile(
        title: Text(_areas[i]),
        shape: const RoundedRectangleBorder(
          side: BorderSide(width: 1),
        ),
      ),
    );
  }

  Widget _buildButtonNewArea(BuildContext context) {
    return RelativeSizedBox(
      percentageHeight: _heightButton,
      child: Container(
        alignment: Alignment.centerRight,
        child: OutlinedButton(
          onPressed: () {},
          child: const Text(_buttonLabelNewArea),
        ),
      ),
    );
  }

  Widget _buildButtonRowEditDelete(BuildContext context) {
    return RelativeSizedBox(
      percentageHeight: _heightButton,
      child: Row(
        children: [
          Expanded(child: Container()),
          OutlinedButton(
            onPressed: () {},
            child: const Text(_buttonLabelEdit),
          ),
          const SizedBox(width: 20),
          OutlinedButton(
            onPressed: () {},
            child: const Text(_buttonLabelDelete),
          ),
        ],
      ),
    );
  }
}
