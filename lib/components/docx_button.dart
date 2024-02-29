import "package:flutter/material.dart";
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner.dart";
import "package:provider/provider.dart";

/// Button used to write and subseqeuntly open a DOCX checklist of a given
/// [Area].
class DOCXButton extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _buttonText = "Create DOCX";

  static const _warnPrefix = "WARNING (DOCXButton):";
  static const _warnNoLandowner = "Landowner not set";

  // Instance Variables ////////////////////////////////////////////////////////
  final Landowner? _landowner;

  // Constructor ///////////////////////////////////////////////////////////////
  const DOCXButton(Area area, Landowner? landowner, {super.key})
      : _landowner = landowner;

  //  //////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async => await _onPressed(context),
      child: const Text(_buttonText),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    final DOCXConverter converter = Provider.of<DOCXConverter>(
      context,
      listen: false,
    );

    if (_landowner == null) {
      debugPrint("$_warnPrefix$_warnNoLandowner");
      return; // Stop early because don't want to build DOCX without landowner.
    }
    debugPrint("${converter.contentControlTags}\n");
  }
}
