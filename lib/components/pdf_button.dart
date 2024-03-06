import "dart:io";
import "package:flutter/material.dart";
import "package:forestryapp/components/exception_alert.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/settings.dart';
import "package:forestryapp/document_converters/pdf_converter.dart";
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner.dart";

/// A button for PDF Generation. When pressed, it creates the pdf using
/// the PdfConverter class, and saves it. The save location is OS-dependant.
class PdfButton extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _buttonText = "Create PDF";
  static const _exceptionPrefix = "Exception (PdfButton)";
  static const _errorNoLandowner = "Landowner not set";
  static const _errorNoSettings = "Evaluator info not set.";
  static const _errorNoName = "Area name not set.";
  static const _errorNoDirectory = "Save directory not found.";

  // Instance variables ////////////////////////////////////////////////////////
  final Area _area;
  final Landowner? _landowner;

  const PdfButton({
    required area,
    required landowner,
    super.key,
  }) : _area = area,
       _landowner = landowner;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async => await _onPressed(context),
      child: const Text(_buttonText),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    // Don't build the PDF without an area title, landowner, and evaluator data.
    if (_area.name == null) {
      ExceptionAlert.alert(context: context, prefix: _exceptionPrefix, message: _errorNoName);
    }

    if (_landowner == null) {
      ExceptionAlert.alert(context: context, prefix: _exceptionPrefix, message: _errorNoLandowner);
      return;
    }
    
    final evaluator = context.read<Settings>();
    if (evaluator.evaluatorName.isEmpty) {
      ExceptionAlert.alert(context: context, prefix: _exceptionPrefix, message: _errorNoSettings);
    }

    // Get the path of the folder in which to store the pdf file.
    // On Android, you must access external storage in order to open the file outside of the app.
    // https://stackoverflow.com/questions/63688285/flutter-platformexceptionerror-failed-to-find-configured-root-that-contains
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getDownloadsDirectory();
    }

    if (directory == null) {
      if (!context.mounted) return;
      ExceptionAlert.alert(context: context, prefix: _exceptionPrefix, message: _errorNoDirectory);
      
    } else {
      try {
        // The path to the save folder
        final file = File("${directory.absolute.path}/${_area.name}.pdf");

        // Builds the PDF widget tree
        final pdf = PdfConverter().create(_area, _landowner, evaluator);

        await file.writeAsBytes(await pdf.save());
        OpenFile.open(file.path);

      } on FileSystemException catch (e) {
        if (!context.mounted) return;
        ExceptionAlert.alert(context: context, prefix: _exceptionPrefix, message: e.message, exception: e);
      }
    }
  }
}
