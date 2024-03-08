import 'package:flutter/material.dart';

import "package:forestryapp/screens/area_index.dart";
import "package:forestryapp/models/area.dart";
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
    Provider.of<Area>(context, listen: false).clearForNewForm();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AreaIndex()),
    );
  }
}
