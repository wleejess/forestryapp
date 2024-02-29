import "dart:io";
import "package:flutter/material.dart";
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
  static const _alertButtonText = "Cancel";

  // Instance Variables ////////////////////////////////////////////////////////
  final Area _area;
  final Landowner? _landowner;

  // Constructor ///////////////////////////////////////////////////////////////
  const DOCXButton(Area area, Landowner? landowner, {super.key})
      : _area = area,
        _landowner = landowner;

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
      _alert(context: context, message: _errorNoLandowner);
      return; // Stop early because don't want to build DOCX without landowner.
    }

    try {
      await converter.convert(
          _area, _landowner, Provider.of<Settings>(context, listen: false));
    } on FileSystemException catch (exception) {
      if (!context.mounted) return;
      _alertFileSystemException(context: context, exception: exception);
    }
  }

  void _alertFileSystemException({
    required BuildContext context,
    required FileSystemException exception,
  }) {
    _alert(context: context, message: exception.message);
  }

  /// Build an alert to show to the user for exception handling.
  ///
  /// Show a human readable [message] to the user while printing the actual
  /// [exception] to console which can be accessed with "flutter logs" command.
  void _alert({
    required BuildContext context,
    required message,
    Exception? exception,
  }) {
    if (exception != null) debugPrint("$_exceptionPrefix: $exception");

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(_exceptionPrefix),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(_alertButtonText),
          )
        ],
      ),
    );
  }
}
