import "dart:io";
import "package:flutter/material.dart";
import "package:forestryapp/components/exception_alert.dart";
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner.dart";
import "package:forestryapp/models/settings.dart";
import "package:provider/provider.dart";

/// Button used to write and subseqeuntly open a DOCX checklist of a given
/// [Area].
class DOCXButton extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _buttonText = "Create DOCX";
  static const _exceptionPrefix = "Exception (DOCXButton)";
  static const _errorNoLandowner = "Landowner not set";

  // Instance Variables ////////////////////////////////////////////////////////
  final Area _area;
  final Landowner? _landowner;

  // Constructor ///////////////////////////////////////////////////////////////
  const DOCXButton(Area area, Landowner? landowner, {super.key})
      : _area = area,
        _landowner = landowner;

  // Methods ///////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async => await _onPressed(context),
      child: const Text(_buttonText),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    if (_landowner == null) {
      ExceptionAlert.alert(context: context, prefix: _exceptionPrefix, message: _errorNoLandowner);
      return; // Stop early because don't want to build DOCX without landowner.
    }

    try {
      await Provider.of<DOCXConverter>(context, listen: false).convert(
        _area,
        _landowner,
        Provider.of<Settings>(context, listen: false),
      );
    } on FileSystemException catch (e) {
      if (!context.mounted) return;
      ExceptionAlert.alert(context: context, prefix: _exceptionPrefix, message: e.message, exception: e);
    }
  }
}
 