import 'package:flutter/material.dart';
import "package:forestryapp/util/break_points.dart";
import "package:forestryapp/database/dao_area.dart";
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:provider/provider.dart";

/// Adjusts the button layout depending on the screen width.
class BottomButtonBuilder {
  static const _buttonTextEmail = "Email";
  static const _buttonTextPDF = "Create PDF";
  static const _buttonTextDOCX = "Create DOCX";
  static const _buttonTextEdit = "Edit";
  static const _buttonTextDelete = "Delete";

  Widget builder(
    BuildContext context,
    BoxConstraints constraints,
    Area area,
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
      child: const Text(_buttonTextEmail),
    );
  }

  Widget _buildButtonPDF(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonTextPDF),
    );
  }

  Widget _buildButtonDOCX(BuildContext context) {
    final DOCXConverter docxConverter = Provider.of<DOCXConverter>(context);
    return OutlinedButton(
      onPressed: () => debugPrint("${docxConverter.contentControlTags}\n"),
      child: const Text(_buttonTextDOCX),
    );
  }

  Widget _buildButtonEdit(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonTextEdit),
    );
  }

  Widget _buildButtonDelete(BuildContext context, Area area) {
    return OutlinedButton(
      onPressed: () => _deleteArea(context, area),
      child: const Text(_buttonTextDelete),
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