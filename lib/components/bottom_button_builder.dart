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
  // Static variables //////////////////////////////////////////////////////////
  static const _buttonTextPDF = "Create PDF";
  static const _buttonTextDOCX = "Create DOCX";
  static const _buttonTextEdit = "Edit";
  static const _buttonTextDelete = "Delete";
  static const _buttonTextCancel = "Cancel";

  // Instance variables //////////////////////////////////////////////////////////;

  Widget builder(
    BuildContext context,
    BoxConstraints constraints,
    Area area,
    List<Widget> buttons,
  ) {
    if (constraints.maxWidth < BreakPoints.widthPhonePortait) {
      return Wrap(
        children: buttons
      );
    }

    return Row(
      children: buttons
    );
  }
}