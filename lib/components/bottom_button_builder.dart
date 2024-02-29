import 'package:flutter/material.dart';
import "package:forestryapp/util/break_points.dart";
import "package:forestryapp/models/area.dart";

/// Adjusts the button layout depending on the screen width.
class BottomButtonBuilder {

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