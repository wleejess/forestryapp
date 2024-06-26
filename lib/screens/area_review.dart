import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/bottom_button_builder.dart";
import "package:forestryapp/components/db_listenable_builder.dart";
import "package:forestryapp/components/docx_button.dart";
import "package:forestryapp/components/edit_button.dart";
import "package:forestryapp/components/error_scaffold.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/pdf_button.dart";
import "package:forestryapp/database/dao_area.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:provider/provider.dart";

/// Screen to view details of a given area saved to the database.
///
/// While this screen is similar to [FormReview] in that PDF/DOCX can be
/// generate4d here, it is differs in that it is only for a saved area while
/// [FormReview] is for an area currently being created/updated.
///
/// Contains an edit button which will set the provided
/// [ChangeNotifierProvider<Area>] to have all the data in the reviewed
/// area. Also contains a deletion button to fully delete the [Area] from the
/// database.
class AreaReview extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";
  static const _notFoundTitle = "Area not found!";
  static const _notFoundBodyText = "Could not find that Area!";
  static const _placeholderForOmitted = "N/A";
  static const _buttonTextDelete = "Delete";

  // Instance variables ////////////////////////////////////////////////////////
  final int _areaID;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Create screen for an existing [Area].
  ///
  /// [areaID] must be an ID for an area saved to the database.
  const AreaReview(int areaID, {super.key}) : _areaID = areaID;

  @override
  State<AreaReview> createState() => _AreaReviewState();
}

class _AreaReviewState extends State<AreaReview> {
  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final Area? area =
        Provider.of<AreaCollection>(context).getByID(widget._areaID);

    // [DBListenableBuilder] necessary for redirecting to error page in event
    // that user was reviewing an area then went to delete its landowner.
    return DBListenableBuilder(
      builder: (_, __) {
        if (area == null) return _buildErrorPage();
        return buildForestryScaffold(area);
      },
    );
  }

  ErrorScaffold _buildErrorPage() {
    return const ErrorScaffold(
      title: AreaReview._notFoundTitle,
      bodyText: AreaReview._notFoundBodyText,
    );
  }

  ForestryScaffold buildForestryScaffold(Area area) {
    final landowner =
        Provider.of<LandownerCollection>(context).getByID(area.landownerID);

    List<Widget> buttons = [
      PdfButton(area: area, landowner: landowner),
      DOCXButton(area, landowner),
      EditButton(area),
      _buildButtonDelete(context, area)
    ];

    return ForestryScaffold(
      title: _titleText(area),
      body: Column(
        children: [
          Expanded(child: AreaProperties(area)),
          LayoutBuilder(
            builder: (context, constraints) {
              return BottomButtonBuilder()
                  .builder(context, constraints, area, buttons);
            },
          ),
        ],
      ),
    );
  }

  // Heading ///////////////////////////////////////////////////////////////////
  String _titleText(Area area) {
    final areaName = area.name ?? AreaReview._placeholderForOmitted;
    return "${AreaReview._titlePrefix}: $areaName";
  }

  Widget _buildButtonDelete(BuildContext context, Area area) {
    return OutlinedButton(
      onPressed: () async => await _deleteArea(context, area),
      child: const Text(AreaReview._buttonTextDelete),
    );
  }

  // Deletion Logic ////////////////////////////////////////////////////////////
  Future<void> _deleteArea(BuildContext context, Area area) async {
    final id = area.id;

    // Check that the area is actually saved in database first.
    if (id != null) {
      await DAOArea.deleteArea(id);
    }

    // NOTE: whenever asynchronous work (e.g. using [await])is performed make
    // sure to check that the widget is still attached to the tree before doing
    // any more work on it. See https://stackoverflow.com/a/69253529
    if (!context.mounted) return;

    await Provider.of<LandownerCollection>(context, listen: false).refetch();
    if (!context.mounted) return;
    await Provider.of<AreaCollection>(context, listen: false).refetch();
    if (!context.mounted) return;

    Navigator.pop(context);
  }
}
