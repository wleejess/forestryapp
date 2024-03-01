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
      List<TableRow> rows = [];

      // Each row must have an equal number of elements
      if (buttons.length % 2 != 0) {
        buttons.add(Container());
      }

      // Evenly divide the buttons into a 2-column table
      for (var i = 0; i < buttons.length; i = i+2) {
        rows.add(
          TableRow(
            children: [
              buttons[i],
              buttons[i+1]
            ]
          )
        );
      }

      return Table(
        children: rows,
      );
    }

    // Make copy as not to mutate original [buttons] List<Widget> or else
    // [Expanded] may end up in the [Table] during orientation change.
    final List<Widget> buttonsInSingleLine = [];
    buttonsInSingleLine.addAll(buttons);

    // Push buttons to the left and right
    int midpoint = buttonsInSingleLine.length ~/ 2;
    buttonsInSingleLine.insert(midpoint, Expanded(child: Container()));

    return Row(children: buttonsInSingleLine);
  }
}
