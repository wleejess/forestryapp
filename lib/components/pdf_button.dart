import "dart:io";
import "package:flutter/material.dart";
import "package:forestryapp/components/error_scaffold.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/settings.dart';
import "package:forestryapp/document_converters/pdf_converter.dart";
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner.dart";

class PdfButton extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _buttonText = "Create PDF";

  // Instance variables ////////////////////////////////////////////////////////
  final Area area;
  final Landowner? landowner;

  const PdfButton({
    required this.area,
    required this.landowner,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final evaluator = context.read<Settings>();

    return OutlinedButton(
      onPressed: () async {
        
        if (landowner != null) {
          // Builds the PDF widget tree
          final pdf = PdfConverter().create(area, landowner!, evaluator);

          // Get the path of the folder in which to store the pdf file.
          // On Android, you must access external storage in order to open the file outside of the app.
          // https://stackoverflow.com/questions/63688285/flutter-platformexceptionerror-failed-to-find-configured-root-that-contains
          final directory = await getExternalStorageDirectory();

          // What about saving files on iOS or web?
          
          if (Platform.isAndroid && directory != null) {
            final file = File("${directory.absolute.path}/${area.name}.pdf");
            await file.writeAsBytes(await pdf.save());

            // What if the file open fails?
            OpenFile.open(file.path);
          } else {
            // Add an error message: No external storage directory
          }
        } else {
          // Add an error message: No landowner
        }
      }, 
      child: const Text(_buttonText),
    );
  }
}
