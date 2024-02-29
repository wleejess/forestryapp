// Design choice: Do not make a singleton for this because it does not satisfy
// the 3 requirements (https://stackoverflow.com/a/228271), particularly it is
// not used in disparate parts of the system (it should only be used in
// [AreaReview]).

import 'dart:io';
import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/models/landowner.dart';
import 'package:forestryapp/models/settings.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

/// Class to manage creating Microsoft DOCX file version of the checklist.
///
/// To instantiate this class use its [create()] method to instantiate objects
/// (there is no public constructor).  This is due to the need for [async]
/// methods involved in reading the DOCX checklist template before the object
/// can be initialized. See https://stackoverflow.com/a/49458289 and
/// https://archive.is/IJVnY for details.
class DOCXConverter {
  // Static Variables //////////////////////////////////////////////////////////
  /// Path to the template checklist DOCX file.
  ///
  /// DOCX file initially provided by Professor Fitzgerald but edited to have
  /// content controls
  /// https://learn.microsoft.com/en-us/office/client-developer/word/content-controls-in-word.
  /// Assumes that the DOCX residing at this path uses Microsoft Word 2013
  /// content controls where the "tag" property is set to have "text", as that
  /// is one of the tags that library [docx_template] is set to recognize.
  static const _pathTemplate = 'assets/templates/checklist-template.docx';

  static const _extension = '.docx';

  // Exception Messages
  static const _noDirectory = "Cannot determine directory to write DOCX files.";
  static const _noBinary = "DOCX Binary could not be generated";
  static const _failWrite = "Could not write DOCX to file system.";
  static const _failOpen = "Could not open written DOCX file.";

  // Instance Variables ////////////////////////////////////////////////////////
  /// Template checklist DOCX file.
  final DocxTemplate _template;
  // ignore: unused_field
  late final Directory? _directoryWrite;

  // Initialization ////////////////////////////////////////////////////////////
  /// Private constructor disables default unnamed constructor.
  ///
  /// This is necessary to avoid making [_template] [late]. Use static method
  /// [create()] to instantiate. This is because constructors cannot be [async]
  /// but initialization involves asynchronous reading of template file.
  DOCXConverter._(this._template);

  /// Create a new instance of DOCXTemplate.
  static Future<DOCXConverter> create() async {
    final converter = DOCXConverter._(await _readTemplate());
    converter._directoryWrite = await _determineWriteDirectoryFromPlatform();
    return converter;
  }

  static Future<DocxTemplate> _readTemplate({BuildContext? context}) async {
    // Design choice: Although in general prefer [DefaultAssetBundle.of()] over
    // [rootBundle()] (per
    // https://docs.flutter.dev/ui/assets/assets-and-images#loading-assets)
    // this method accounts for cases where [BuildContext] may not be available
    // (e.g. from in [main()] or [initState()]). Hence the [if] branch where
    // [rootBundle] is used.
    final ByteData templateBinary;

    if (context != null) {
      // Inside widget tree.
      templateBinary = await DefaultAssetBundle.of(context).load(_pathTemplate);
    } else {
      // Outside widget tree (e.g. from [main()] or [initState()])
      templateBinary = await rootBundle.load(_pathTemplate);
    }

    return DocxTemplate.fromBytes(Uint8List.sublistView(templateBinary));
  }

  /// Find the path of directoryof where to write the DOCX files.
  ///
  /// On Android this will save to
  /// "/storage/emulated/0/Android/data/com.example.forestryapp/files/".
  static Future<Directory?> _determineWriteDirectoryFromPlatform() async {
    // We use [getExternalStorageDirectory()] instead of
    // [getApplicationDocumentsDirectory()] for Android because the latter is
    // part of the asset bundle which is not accessible to the user. The asset
    // bundle is however accessible to the app as that is where the checklist
    // DOCX template is stored in [_pathTemplate].
    if (Platform.isAndroid) return await getExternalStorageDirectory();
    if (Platform.isIOS) return await getApplicationDocumentsDirectory();
    return await getDownloadsDirectory();
  }

  // Getters ///////////////////////////////////////////////////////////////////

  /// Get list of all content control "title" properties found in [_template]
  /// DOCX file.
  List<String> get contentControlTags => _template.getTags();

  /// Directory which to write the DOCX files to.
  Directory? get directoryWrite => _directoryWrite;

  // Conversion Logic //////////////////////////////////////////////////////////

  /// Performs DOCX document conversion by writing to [directoryWrite] and
  /// subsequently opening the resulting file in an appropriate DOCX reading
  /// app.
  ///
  /// Callers should be aware that this method can throw [FileSystemException]
  /// and should prepare to handle them appropriately.
  Future<void> convert(
    Area area,
    Landowner landowner,
    Settings settings,
  ) async {
    final docxBytes = await _generateDOCXBinary(area, landowner, settings);
    final File docxFile = File(_determinePathToDOCX(area, landowner));
    await _writeDOCXToFile(docxFile, docxBytes);
    await _openDOCX(docxFile, docxBytes);
  }

  /// Create the bytes data to be written to file.
  Future<List<int>> _generateDOCXBinary(
      Area area, Landowner landowner, Settings settings) async {
    final Content docxContent = _pullModelDataToDOCX(area, landowner, settings);
    final List<int>? docxBytes = await _template.generate(docxContent);
    if (docxBytes == null) throw const FileSystemException(_noBinary);
    return docxBytes;
  }

  String _determinePathToDOCX(Area area, Landowner landowner) {
    if (_directoryWrite == null) throw const FileSystemException(_noDirectory);
    const String basenameWithoutExtension = 'checklist';
    return '${_directoryWrite.path}/$basenameWithoutExtension$_extension';
  }

  Future<void> _writeDOCXToFile(File fileGenerated, List<int> docxBytes) async {
    try {
      await fileGenerated.writeAsBytes(docxBytes);
    } catch (e) {
      debugPrint("DOCX WRITE FAIL: $e");
      throw const FileSystemException(_failWrite);
    }
  }

  Future<void> _openDOCX(File fileGenerated, List<int> docxBytes) async {
    // WARNING: If user does not have an appropriate app to open DOCX, it will
    // appear as if this method does nothing. This is the case on the vanilla
    // Android emulator as it has no default app to open
    try {
      OpenFile.open(fileGenerated.path);
    } catch (e) {
      debugPrint("DOCX OPEN FAIL: $e");
      throw const FileSystemException(_failOpen);
    }
  }

  // Logic For Adding Model Data To DOCX ///////////////////////////////////////
  Content _pullModelDataToDOCX(
      Area area, Landowner landowner, Settings settings) {
    final Content content = Content();
    return content;
  }
}
