// Design choice: Do not make a singleton for this because it does not satisfy
// the 3 requirements (https://stackoverflow.com/a/228271), particularly it is
// not used in disparate parts of the system (it should only be used in
// [AreaReview]).

import 'dart:io';
import "package:universal_html/html.dart" as html;
import 'package:docx_template/docx_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestryapp/enums/us_state.dart';
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
  static const _omitted = 'N/A';

  // Exception Messages
  static const _noDirectory = "Cannot determine directory to write DOCX files.";
  static const _noBinary = "DOCX Binary could not be generated";
  static const _failWrite = "Could not write DOCX to file system.";
  static const _failOpen = "Could not open written DOCX file.";
  static const _noDOCXAppFoundPrefix = "DOCX file written to '";
  static const _noDOCXAppFoundSuffix =
      "' but no app for opening DOCX files detected.";

  // Instance Variables ////////////////////////////////////////////////////////
  /// Template checklist DOCX file.
  final DocxTemplate _template;
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
    // TODO: Determine where to write files when app is deployed on web. For the
    // time being this is necesssary as path_provider does not support web
    // (i.e. calling getDownloadsDirectory() would crash the web app). This MUST
    // come before Platform.isAndroid and Platform.isIOS or else the web app
    // will complain that those names aren't available.
    if (kIsWeb) return null;

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
  /// and should prepare to handle them appropriately. This is meant to be
  /// caught on the layout side to show an [AlertDialog].
  Future<void> convert(
    Area area,
    Landowner landowner,
    Settings settings,
  ) async {
    final docxBytes = await _generateDOCXBinary(area, landowner, settings);

    if (kIsWeb) {
      handleDOCXOnWeb(docxBytes);
      return;
    }

    final File docxFile = File(_createPathToDOCX(area, landowner));
    await _writeDOCXToFile(docxFile, docxBytes);
    await _openDOCX(docxFile);
  }

  /// Create the bytes data to be written to file.
  ///
  /// Created bytes will contain all current model information.  Callers should
  /// be aware that this method can throw [FileSystemException] if bytes
  /// generation (see [generate()] from
  /// "https://github.com/PavelS0/docx_template_dart/blob/7fbe5e2c9390d9f8e6454eb7720b8815c01af4d4/lib/src/template.dart#L90")
  /// happens to fail. This is meant to be caught on the layout side to show an
  /// [AlertDialog].
  Future<List<int>> _generateDOCXBinary(
      Area area, Landowner landowner, Settings settings) async {
    final Content docxContent = _pullModelDataToDOCX(area, landowner, settings);
    final List<int>? docxBytes = await _template.generate(docxContent);
    if (docxBytes == null) throw const FileSystemException(_noBinary);
    return docxBytes;
  }

  /// Use [area] and [landowner] data to create a unique path to write DOCX.
  ///
  /// Callers should be aware that this method can throw [FileSystemException]
  /// if the directory to write the DOCX [_directoryWrite] happens to be
  /// [null]. This is meant to be caught on the layout side to show an
  /// [AlertDialog].
  String _createPathToDOCX(Area area, Landowner landowner) {
    if (_directoryWrite == null) throw const FileSystemException(_noDirectory);
    // Include area ID in filename because there is no uniqueness constraint on
    // the area name (landowners might have two areas with same name).
    final String basenameWithoutExtension =
        '${landowner.name}-${area.name}-${area.id}';
    return '${_directoryWrite.path}/$basenameWithoutExtension$_extension';
  }

  /// Write [docxBytes] binary data to specified file object [fileGenerated].
  ///
  /// Callers should be aware that this method can throw [FileSystemException]
  /// if ANY exception is thrown during the writing process. This is meant to be
  /// caught on the layout side to show an [AlertDialog].
  Future<void> _writeDOCXToFile(File fileGenerated, List<int> docxBytes) async {
    try {
      await fileGenerated.writeAsBytes(docxBytes);
    } catch (e) {
      debugPrint("DOCX WRITE FAIL: $e");
      throw const FileSystemException(_failWrite);
    }
  }

  /// Opens the [fileGenerated] in appropriate app on user's device.
  ///
  /// Callers should be aware that this method can throw [FileSystemException]
  /// if ANY exception is thrown during the opening process. This is meant to be
  /// caught on the layout side to show an [AlertDialog].
  ///
  /// If the user's device has no appropriate app installed to open
  /// [fileGenerated] this method will have no effect.
  Future<void> _openDOCX(File fileGenerated) async {
    // WARNING: If user does not have an appropriate app to open DOCX, it will
    // appear as if this method does nothing. This is the case on the vanilla
    // Android emulator as it has no default app to open
    final path = fileGenerated.path;
    OpenResult? result;

    try {
      result = await OpenFile.open(path);
      // Throw into [catch] if no app is found in order to alert the user they
      // don't have any DOCX apps installed.
      if (result.type == ResultType.noAppToOpen) throw Exception();
    } catch (e) {
      final String exceptionMessage;

      if (result != null && result.type == ResultType.noAppToOpen) {
        exceptionMessage = _formatNoDOCXAppMessage(path);
      } else {
        // Handling any other exception.
        debugPrint("DOCX OPEN FAIL: $e");
        exceptionMessage = _failOpen;
      }

      throw FileSystemException(exceptionMessage);
    }
  }

  // Logic For Adding Model Data To DOCX ///////////////////////////////////////
  Content _pullModelDataToDOCX(
      Area area, Landowner landowner, Settings settings) {
    final Content content = Content();
    _pullBasicInformation(content, landowner, area);
    _pullSiteCharacteristics(content, area);
    _pullVegetativeConditions(content, area);
    _pullDamages(content, area);
    _pullMistletoe(content, area);
    _pullLongResponse(content, area);
    _pullEvaluator(content, settings);
    return content;
  }

  void _pullBasicInformation(Content content, Landowner landowner, Area area) {
    content
      ..add(TextContent("landowner_name", landowner.name))
      ..add(TextContent(
        "landowner_address",
        _formatAddress(
          landowner.address,
          landowner.city,
          landowner.state,
          landowner.zip,
        ),
      ))
      ..add(TextContent("landowner_email", landowner.email))
      ..add(TextContent("area_name", area.name))
      ..add(TextContent("acres", area.acres))
      ..add(TextContent("landowner_goals", area.goals ?? _omitted));
  }

  void _pullSiteCharacteristics(
    Content content,
    Area area,
  ) {
    content
      ..add(TextContent("elevation", area.elevation ?? _omitted))
      ..add(TextContent("aspect", area.aspect.label))
      ..add(TextContent("slope_percentage", area.slopePercentage ?? _omitted))
      ..add(TextContent("slope_position", area.slopePosition.label))
      ..add(TextContent("soil_information", area.soilInfo ?? _omitted));
  }

  void _pullVegetativeConditions(
    Content content,
    Area area,
  ) {
    content
      ..add(TextContent("cover_type", area.coverType.label))
      ..add(TextContent("stand_structure", area.standStructure.label))
      ..add(TextContent("overstory_stand_density", area.overstoryDensity.label))
      ..add(TextContent(
        "overstory_species_composition",
        area.overstorySpeciesComposition ?? _omitted,
      ))
      ..add(TextContent(
        "understory_stand_density",
        area.understoryDensity.label,
      ))
      ..add(TextContent(
        "understory_species_composition",
        area.understorySpeciesComposition ?? _omitted,
      ))
      ..add(TextContent("stand_history", area.standHistory ?? _omitted));
  }

  void _pullDamages(Content content, Area area) {
    content
      ..add(TextContent("insects", area.insects ?? _omitted))
      ..add(TextContent("diseases", area.diseases ?? _omitted))
      ..add(TextContent("invasives", area.invasives ?? _omitted))
      ..add(TextContent("wildlife", area.wildlifeDamage ?? _omitted));
  }

  void _pullMistletoe(Content content, Area area) {
    content
      ..add(TextContent("mistletoe_uniformity", area.mistletoeUniformity.label))
      ..add(TextContent(
        "mistletoe_location",
        area.mistletoeLocation ?? _omitted,
      ))
      ..add(TextContent("hawksworth", area.hawksworth.label))
      ..add(TextContent(
        "mistletoe_tree_species_infected",
        area.mistletoeTreeSpecies ?? _omitted,
      ));
  }

  void _pullLongResponse(Content content, Area area) {
    content
      ..add(TextContent("road_health", area.roadHealth ?? _omitted))
      ..add(TextContent("water_issues", area.waterHealth ?? _omitted))
      ..add(TextContent("fire_risk", area.fireRisk ?? _omitted))
      ..add(TextContent("other_issues", area.otherIssues ?? _omitted))
      ..add(TextContent("diagnosis", area.diagnosis ?? _omitted));
  }

  void _pullEvaluator(Content content, Settings settings) {
    content
      ..add(TextContent("evaluator_name", settings.evaluatorName))
      ..add(TextContent("evaluator_email", settings.evaluatorEmail))
      ..add(TextContent(
        "evaluator_address",
        _formatAddress(
          settings.evaluatorAddress,
          settings.evaluatorCity,
          settings.evaluatorUSState,
          settings.evaluatorZip,
        ),
      ));
  }

  // Web Version ///////////////////////////////////////////////////////////////
  void handleDOCXOnWeb(List<int> docxBytes) {
    final blob = html.Blob(
      [docxBytes],
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    );
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url).click();
    html.Url.revokeObjectUrl(url);
  }

  // Helpers ///////////////////////////////////////////////////////////////////
  String _formatAddress(
    String address,
    String city,
    USState? usState,
    String zip,
  ) {
    return "$address $city, ${usState?.label.toUpperCase() ?? ''} $zip ";
  }

  String _formatNoDOCXAppMessage(String path) =>
      "$_noDOCXAppFoundPrefix$path$_noDOCXAppFoundSuffix";
}
