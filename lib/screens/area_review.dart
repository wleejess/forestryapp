import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/db_listenable_builder.dart";
import "package:forestryapp/components/error_scaffold.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/database/dao_area.dart";
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/models/landowner.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/util/break_points.dart";
import "package:provider/provider.dart";

class AreaReview extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";
  static const _notFoundTitle = "Area not found!";
  static const _notFoundBodyText = "Could not find that Area!";
  static const _placeholderForOmitted = "N/A";
  static const _buttonTextEmail = "Email";
  static const _buttonTextPDF = "Create PDF";
  static const _buttonTextDOCX = "Create DOCX";
  static const _buttonTextEdit = "Edit";
  static const _buttonTextDelete = "Delete";

  // Instance variables ////////////////////////////////////////////////////////
  final int _areaID;

  // Constructor ///////////////////////////////////////////////////////////////
  const AreaReview(int areaID, {super.key}) : _areaID = areaID;

  @override
  State<AreaReview> createState() => _AreaReviewState();
}

class _AreaReviewState extends State<AreaReview> {
  // State Variables ///////////////////////////////////////////////////////////
  late final DOCXConverter _docxConverter;

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    _initializeConverters();
  }

  void _initializeConverters() async {
    _docxConverter = await DOCXConverter.create();
  }

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
    return ForestryScaffold(
      title: _titleText(area),
      body: Column(
        children: [
          Expanded(child: AreaProperties(area)),
          LayoutBuilder(
            builder: (context, contraints) {
              return _bottomButtonbuilder(context, contraints, area);
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

  // Button Layout /////////////////////////////////////////////////////////////
  Widget _bottomButtonbuilder(
    BuildContext context,
    BoxConstraints constraints,
    Area area,
  ) {
    // ignore: unused_local_variable
    final Landowner? landowner =
        Provider.of<LandownerCollection>(context).landownerOfReviewedArea;

    if (constraints.maxWidth < BreakPoints.widthPhonePortait) {
      return Table(
        children: [
          TableRow(children: [
            _buildButtonDOCX(context),
            _buildButtonEmail(context),
          ]),
          TableRow(children: [
            _buildButtonPDF(context),
            _buildButtonEdit(context),
          ]),
          TableRow(children: [
            Container(),
            _buildButtonDelete(context, area),
          ]),
        ],
      );
    }

    return Row(
      children: [
        _buildButtonPDF(context),
        _buildButtonDOCX(context),
        Expanded(child: Container()),
        _buildButtonEmail(context),
        _buildButtonEdit(context),
        _buildButtonDelete(context, area),
      ],
    );
  }

  Widget _buildButtonEmail(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(AreaReview._buttonTextEmail),
    );
  }

  Widget _buildButtonPDF(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(AreaReview._buttonTextPDF),
    );
  }

  Widget _buildButtonDOCX(BuildContext context) {
    return OutlinedButton(
      onPressed: () => debugPrint("${_docxConverter.contentControlTags}\n"),
      child: const Text(AreaReview._buttonTextDOCX),
    );
  }

  Widget _buildButtonEdit(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(AreaReview._buttonTextEdit),
    );
  }

  Widget _buildButtonDelete(BuildContext context, Area area) {
    return OutlinedButton(
      onPressed: () => _deleteArea(context, area),
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
    if (!context.mounted) return;

    await Provider.of<LandownerCollection>(context, listen: false).refetch();
    if (!context.mounted) return;
    await Provider.of<AreaCollection>(context, listen: false).refetch();
    if (!context.mounted) return;

    Navigator.pop(context);
  }
}
