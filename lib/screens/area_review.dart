import "dart:io";

import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/error_scaffold.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/settings.dart';
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/document_converters/pdf_converter.dart";
import "package:forestryapp/util/break_points.dart";
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";

class AreaReview extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";
  static const _notFoundTitle = "Landowner not found!";
  static const _notFoundBodyText = "Could not find that landowner!";
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
          Expanded(child: _buildAreaPropertiesListView(context, area)),
          LayoutBuilder(builder: _bottomButtonbuilder),
        ],
      ),
    );
  }

  // Heading ///////////////////////////////////////////////////////////////////
  Widget _buildAreaPropertiesListView(BuildContext context, Area area) {
    // For now, use `ListView` instead of `ListView.builder` to give finer
    // control over order in which checklist items appear as well as allowing
    // future tweaking of appearance of certain properties (e.g. landowner
    // should be tappable to navigate to landowner, multi-valued properties may
    // be displayed in a list).
    return AreaProperties(area);
  }

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
    final areaListenable = Provider.of<AreaCollection>(context);
    final Area? area = areaListenable.getAreaByID(widget._areaID);
    // Also get the Landowner object to pass in

    return OutlinedButton(
      onPressed: () async {
        // Build the PDF widget tree
        if (area != null) {
          final pdf = PdfConverter().create(area, context.read<Settings>());

          // Get the path of the folder in which to store the pdf file.
          // On Android, you must access external storage in order to open the file outside of the app.
          // https://stackoverflow.com/questions/63688285/flutter-platformexceptionerror-failed-to-find-configured-root-that-contains
          final directory = await getExternalStorageDirectory();

          // Need to add an alternative if using iOS
          if (directory != null) {
            final file = File("${directory.absolute.path}/forest_wellness_checkup.pdf");
            await file.writeAsBytes(await pdf.save());
            OpenFile.open(file.path);
          } else {
            // Change this to display an error message.
            print("External storage directory is null.");
          }
        } else {
          print("Area not found.");
        }
      },
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
