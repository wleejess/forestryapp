import "package:flutter/material.dart";
import "package:forestryapp/components/contact_info.dart";
import "package:forestryapp/components/db_listenable_builder.dart";
import "package:forestryapp/components/error_scaffold.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/database/dao_landowner.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/models/landowner.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/screens/area_review.dart";
import "package:forestryapp/screens/basic_information_form.dart";
import "package:forestryapp/screens/landowner_edit.dart";
import "package:forestryapp/util/break_points.dart";
import "package:provider/provider.dart";


/// Screen for displaying information about a [Landowner] saved to the database.
///
/// This screen will list contact information of said [Landowner] as well as a
/// scrollable [ListView] of any areas they may own. If users choose to create
/// an [Area] its landowner will be set to the [Landowner] associated with this
/// screen.
class LandownerReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Landowner Review";
  static const _areasHeading = "Areas";
  static const _buttonLabelNewArea = "New Area";
  static const _buttonLabelEdit = "Edit";
  static const _buttonLabelDelete = "Delete";

  static const _notFoundTitle = "Landowner not found!";
  static const _notFoundBodyText = "Could not find that landowner!";

  static const _notFoundAreaTitle = "Area not found!";
  static const _notFoundAreaBody = "Could not find that area!";

  static const _areaMissingTitle = "N/A";

  // Instance variables ////////////////////////////////////////////////////////
  // NOTE: These will be refactored into a single model class later on.
  final int _landownerID;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to see details on a single landowner.
  const LandownerReview({
    // Pass ID instead an actual landowner because it is possible the model
    // object could be out of date after the user edited the given landowner and
    // saved their changes to the database.
    required int landownerID,
    super.key,
  }) : _landownerID = landownerID;

  // Methods ///////////////////////////////////////////////////////////////////
  /// Conditionally rebuild entire screen.
  ///
  /// While listening for changes in the known landowners, rebuild when
  /// detecting a change (i.e. landowners created/updated/deleted). Do this to
  /// avoid having [_landowner] having out of date data (i.e. not showing
  /// changes that have been already made on the database.)
  @override
  Widget build(BuildContext context) {
    return DBListenableBuilder(
      builder: (context, child) {
        final Landowner? landowner =
            Provider.of<LandownerCollection>(context).getByID(_landownerID);

        // Show an error page if the [landowner] is [null] for whatever reason.
        // Otherwise show the landowner's information.
        if (landowner == null) {
          return const ErrorScaffold(
            title: _notFoundTitle,
            bodyText: _notFoundBodyText,
          );
        }

        return ForestryScaffold(
          title: "$_title: ${landowner.name}",
          body: LayoutBuilder(
            builder: (context, constraints) =>
                _buildBasedOnAvailableVerticalSpace(
              context,
              constraints,
              landowner,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBasedOnAvailableVerticalSpace(
    BuildContext context,
    BoxConstraints constraints,
    Landowner landowner,
  ) {
    final contactInfo = ContactInfo(
      name: landowner.name,
      email: landowner.email,
      combinedAddress: formatAddress(landowner),
    );
    final ListView areas = _buildAreas(context);
    final buttons = _buildButtonRow(context, landowner);

    if (constraints.maxHeight < BreakPoints.widthPhonePortait) {
      return _buildLayoutSideBySide(context, contactInfo, areas, buttons);
    }

    return _buildLayoutVertically(context, contactInfo, areas, buttons);
  }

  Widget _buildLayoutSideBySide(
    BuildContext context,
    Widget contactInfo,
    ListView areas,
    Widget buttons,
  ) {
    // Don't make heading on side by side layout because vertical space is
    // already assumed to be pretty scarce if this method is called. Do this
    // because if vertical space is scarce then it will be hard to scroll
    // through the area ListView.
    return Column(children: [
      Expanded(child: Row(children: [contactInfo, Expanded(child: areas)])),
      buttons
    ]);
  }

  Widget _buildLayoutVertically(BuildContext context, Widget contactInfo,
      ListView areas, Widget buttons) {
    final areaSection = Column(
      // Use Expanded to constrain greedy ListView in [areas].
      children: [_buildAreasHeading(context), Expanded(child: areas)],
    );
    return Column(
      children: <Widget>[contactInfo, Expanded(child: areaSection), buttons],
    );
  }

  String formatAddress(Landowner landowner) {
    final String state;

    if (landowner.state == null) {
      // This should not be null for landowners coming from database because
      // schema enforces non-null on said field, but check it just for null
      // safety linting's sake.
      state = '';
    } else {
      state = landowner.state!.label.toUpperCase();
    }

    return "${landowner.address} ${landowner.city}, $state ${landowner.zip}";
  }

  // Areas /////////////////////////////////////////////////////////////////////
  Widget _buildAreasHeading(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      alignment: Alignment.bottomLeft,
      child: Text(
        _areasHeading,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  ListView _buildAreas(BuildContext context) {
    final areas = Provider.of<AreaCollection>(context).areasOfReviewedLandowner;

    return ListView.builder(
      itemCount: areas.length,
      itemBuilder: (context, i) => _buildAreaListItem(context, i, areas),
    );
  }

  Widget _buildAreaListItem(BuildContext context, int i, List<Area> areas) {
    // Use `Card` for work around with overlapping `ListTiles`
    // https://github.com/flutter/flutter/issues/94261#issuecomment-983166280
    return Card(
      child: ListTile(
        title: Text(areas[i].name ?? _areaMissingTitle),
        shape: const RoundedRectangleBorder(
          side: BorderSide(width: 1),
        ),
        onTap: () async => await _tapOnArea(context, areas[i]),
      ),
    );
  }

  Future<void> _tapOnArea(BuildContext context, Area area) async {
    final areaID = area.id;

    if (!context.mounted) return;

    final Widget destination;

    if (areaID == null) {
      destination = const ErrorScaffold(
        title: _notFoundAreaTitle,
        bodyText: _notFoundAreaBody,
      );
    } else {
      destination = AreaReview(areaID);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  // Buttons ///////////////////////////////////////////////////////////////////
  /// Layout buttons so they are on the right side of their parent.
  ///
  /// [landowner] should be the landowner being reviewed so that it can be
  /// edited or deleted.
  Widget _buildButtonRow(BuildContext context, Landowner landowner) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
          onPressed: () => _startFormForNewAreaWithCurrentLandowner(context),
          child: const Text(_buttonLabelNewArea),
        ),
        OutlinedButton(
          onPressed: () => _navigateEdit(context, landowner),
          child: const Text(_buttonLabelEdit),
        ),
        OutlinedButton(
          onPressed: () async => await _navigateDelete(context, landowner),
          child: const Text(_buttonLabelDelete),
        ),
      ],
    );
  }

  void _startFormForNewAreaWithCurrentLandowner(BuildContext context) {
    final formArea = Provider.of<Area>(context, listen: false);
    formArea.clearForNewForm();
    formArea.landownerID = _landownerID;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BasicInformationForm()),
    );
  }

  /// Navigate to the screen for editing [landowner].
  ///
  /// ASSUMPTION: [landowner] represents a valid record existing in the
  /// database.
  void _navigateEdit(BuildContext context, Landowner landowner) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LandownerEdit(landownerToEdit: landowner),
      ),
    );
  }

  /// Delete the landowner being reviewed and navigate back to previous screen.
  ///
  /// ASSUMPTION: Previous screen needs to be listening to [LandownerCollection]
  /// or else it won't show that the landowner was deleted.
  Future<void> _navigateDelete(BuildContext context, Landowner landowner) async {
    // Keep as separate method to avoid using context across async gap.
    await _deleteLandowner(context, landowner);
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  Future<void> _deleteLandowner(BuildContext context, Landowner landowner) async {
    await DAOLandowner.deleteLandowner(landowner.id);
    if (!context.mounted) return;
    // Refetch areas too because when an landowner gets deleted so do its
    // areas. See "on delete cascade" option in schema
    // [assets/database/schema/areas.sql].
    await Provider.of<LandownerCollection>(context, listen: false).refetch();
    if (!context.mounted) return;
    await Provider.of<AreaCollection>(context, listen: false).refetch();
  }
}
