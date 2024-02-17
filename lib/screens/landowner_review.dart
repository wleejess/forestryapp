import "package:flutter/material.dart";
import "package:forestryapp/components/contact_info.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/models/landowner.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/screens/landowner_edit.dart";
import "package:provider/provider.dart";

class LandownerReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Landowner Review";
  static const _areasHeading = "Areas";
  static const _buttonLabelNewArea = "New Area";
  static const _buttonLabelEdit = "Edit";
  static const _buttonLabelDelete = "Delete";

  // Instance variables ////////////////////////////////////////////////////////
  // NOTE: These will be refactored into a single model class later on.
  final int _landownerID;
  final List<String> _areas;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to see details on a single landowner.
  const LandownerReview({
    // Pass ID instead an actual landowner because it is possible the model
    // object could be out of date after the user edited the given landowner and
    // saved their changes to the database.
    required int landownerID,
    required List<String> areas,
    super.key,
  })  : _landownerID = landownerID,
        _areas = areas;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Provider.of<LandownerCollection>(context),
      builder: (context, child) {
        return _buildForestryScaffold(context);
      },
    );
  }

  ForestryScaffold _buildForestryScaffold(BuildContext context) {
    final Landowner? landowner = Provider.of<LandownerCollection>(context)
        .getLandownerByID(_landownerID);

    return ForestryScaffold(
      title: "$_title: ${landowner!.name}",
      body: Column(
        children: <Widget>[
          ContactInfo(
            name: landowner.name,
            email: landowner.email,
            combinedAddress: formatAddress(landowner),
          ),
          _buildAreasHeading(context),
          // Use `Expanded` to both (1) constrain `ListView` from exceeding
          // total height and (2) force the "Edit" and "Delete" buttons all the
          // way down to the bottom of the screen. Unfortunately when the number
          // of items in the `ListView` cause the ListView to not take up as
          // much or more than its `Expanded` parent, the "New Area" button is
          // also forced to bottom instead of being flush with last Area
          // `ListTile`. This is because the expanded `ListView` expands past its
          // last `ListTile`.
          Expanded(child: _buildAreas(context)),
          _buildButtonNewArea(context),
          _buildButtonRowEditDelete(context, landowner),
        ],
      ),
    );
  }

  String formatAddress(Landowner landowner) {
    final String state;

    if (landowner.state == null) {
      state = '';
    } else {
      state = landowner.state!.label.toUpperCase();
    }

    return "${landowner.address} ${landowner.city}, $state ${landowner.zip}";
  }

  // Areas Heading /////////////////////////////////////////////////////////////
  Widget _buildAreasHeading(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        _areasHeading,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  // Areas /////////////////////////////////////////////////////////////////////
  Widget _buildAreas(BuildContext context) {
    return ListView.builder(
      itemCount: _areas.length,
      itemBuilder: _buildAreaListItem,
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

  // Buttons ///////////////////////////////////////////////////////////////////
  Widget _buildButtonNewArea(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: OutlinedButton(
        onPressed: () {},
        child: const Text(_buttonLabelNewArea),
      ),
    );
  }

  Widget _buildButtonRowEditDelete(BuildContext context, Landowner landowner) {
    return Row(
      children: [
        Expanded(child: Container()),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LandownerEdit(landownerToEdit: landowner),
              ),
            );
          },
          child: const Text(_buttonLabelEdit),
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          onPressed: () {},
          child: const Text(_buttonLabelDelete),
        ),
      ],
    );
  }
}
