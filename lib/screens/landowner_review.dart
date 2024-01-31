import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

class LandownerReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Landowner Review";
  static const _areasHeading = "Areas";
  static const _buttonLabelNewArea = "New Area";
  static const _buttonLabelEdit = "Edit";
  static const _buttonLabelDelete = "Delete";

  // Instance variables ////////////////////////////////////////////////////////
  // NOTE: These will be refactored into a single model class later on.
  final String _name;
  final String _email;
  final String _combinedAddress;
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
        _combinedAddress = "$streetAddress $city, $state $zipCode",
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
          _buildButtonRowEditDelete(context),
        ],
      ),
    );
  }

  // Contact Info //////////////////////////////////////////////////////////////
  Widget _buildContactInfo(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            _name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          _buildContactInfoTable()
        ],
      ),
    );
  }

  Table _buildContactInfoTable() {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        TableRow(children: _buildTableRow("Email", _email)),
        TableRow(children: _buildTableRow("Address", _combinedAddress)),
      ],
    );
  }

  List<Widget> _buildTableRow(String label, String info) {
    return [
      Container(
          alignment: Alignment.centerRight,
          child: Text("$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold))),
      SelectableText(info),
    ];
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

  Widget _buildButtonRowEditDelete(BuildContext context) {
    return Row(
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
    );
  }
}
