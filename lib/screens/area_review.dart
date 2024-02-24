import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/error_scaffold.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
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
    final areaListenable = Provider.of<AreaCollection>(context);
    final Area? area = areaListenable.getAreaByID(widget._areaID);

    if (area == null) {
      return const ErrorScaffold(
        title: AreaReview._notFoundTitle,
        bodyText: AreaReview._notFoundBodyText,
      );
    }

    return ForestryScaffold(
      title: _titleText(area),
      body: Column(
        children: [
          Expanded(child: AreaProperties(area)),
          LayoutBuilder(builder: _bottomButtonbuilder),
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
  ) {
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
            _buildButtonDelete(context),
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
        _buildButtonDelete(context),
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

  Widget _buildButtonDelete(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(AreaReview._buttonTextDelete),
    );
  }
}
