import 'package:flutter/material.dart';

import "package:forestryapp/screens/area_index.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/screens/area_review.dart";
import "package:provider/provider.dart";

class CancelFormSummaryButton extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _buttonTextCancel = "Cancel";

  // Constructor ///////////////////////////////////////////////////////////////
  const CancelFormSummaryButton({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _cancel(context),
      child: const Text(_buttonTextCancel),
    );
  }

  void _cancel(BuildContext context) {
    final area = Provider.of<Area>(context, listen: false);
    final id = area.id;
    final Widget Function(BuildContext) destination;

    // NOTE: Clearing the form with `area.clearForNewForm()` will trigger
    // `AreaProperties` used in `FormReview`validation to fail because clearing
    // will set area._name and area._landownerID will be set to `null`. This
    // will cause a very quick and temporary change in `FormReview` before
    // navigating away. There would probably be a better way of implementing
    // this.

    if (id != null) {
      destination = (context) => AreaReview(id);
    } else {
      destination = (context) => const AreaIndex();
    }

    Navigator.push(context, MaterialPageRoute(builder: destination));
  }
}
