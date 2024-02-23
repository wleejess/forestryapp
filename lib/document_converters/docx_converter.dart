// Design choice: Do not make a singleton for this because it does not satisfy
// the 3 requirements (https://stackoverflow.com/a/228271), particularly it is
// not used in disparate parts of the system (it should only be used in
// [AreaReview]).

import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // Instance Variables ////////////////////////////////////////////////////////
  /// Template checklist DOCX file.
  final DocxTemplate _template;

  // Initialization ////////////////////////////////////////////////////////////
  /// Private constructor disables default unnamed constructor.
  ///
  /// This is necessary to avoid making [_template] [late]. Use static method
  /// [create()] to instantiate. This is because constructors cannot be [async]
  /// but initialization involves asynchronous reading of template file.
  DOCXConverter._(this._template);

  /// Create a new instance of DOCXTemplate.
  static Future<DOCXConverter> create() async =>
      DOCXConverter._(await _readTemplate());

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

  //  //////////////////////////////////////////////////////////////////////////

  /// Get list of all content control "title" properties found in [_template]
  /// DOCX file.
  List<String> get contentControlTags => _template.getTags();
}