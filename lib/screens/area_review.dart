import "dart:io";

import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/settings.dart';
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/document_converters/pdf_converter.dart";
import "package:forestryapp/util/break_points.dart";
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class AreaReview extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";

  static const _placeholderForOmitted = "Omitted";
  static const _unitElevation = 'ft';
  static const _unitSlopePercentage = "%";
  static const _unitSpeciesComposition = "%";

  static const _buttonTextEmail = "Email";
  static const _buttonTextPDF = "Create PDF";
  static const _buttonTextDOCX = "Create DOCX";
  static const _buttonTextEdit = "Edit";
  static const _buttonTextDelete = "Delete";

  // Instance variables ////////////////////////////////////////////////////////

  final String _name;

  final String? _landowner,
      _acres,
      _goals,
      _elevation,
      _aspect,
      _slopePercentage,
      _slopePosition,
      _soilInfo,
      _coverType,
      _standStructure,
      _overstoryDensity,
      _overstorySpeciesComposition,
      _understoryDensity,
      _understorySpeciesComposition,
      _siteHistory,
      _insects,
      _diseases,
      _ivasives,
      _wildlifeDamage,
      _mistletoeUniformity,
      _mistletoeLocation,
      _hawksworth,
      _mistletoeTreeSpecies,
      _roadHealth,
      _waterHealth,
      _fireRisk,
      _otherIssues,
      _diagnosis;

  // Constructor ///////////////////////////////////////////////////////////////
  const AreaReview({
    required String name,
    String? landowner,
    String? acres,
    String? goals,
    String? elevation,
    String? aspect,
    String? slopePercentage,
    String? slopePosition,
    String? soilInfo,
    String? coverType,
    String? standStructure,
    String? overstoryDensity,
    String? overstorySpeciesComposition,
    String? understoryDensity,
    String? understorySpeciesComposition,
    String? siteHistory,
    String? insects,
    String? diseases,
    String? ivasives,
    String? wildlifeDamage,
    String? mistletoeUniformity,
    String? mistletoeLocation,
    String? hawksworth,
    String? mistletoeTreeSpecies,
    String? roadHealth,
    String? waterHealth,
    String? fireRisk,
    String? otherIssues,
    String? diagnosis,
    super.key,
  })  : _name = name,
        _landowner = landowner,
        _acres = acres,
        _goals = goals,
        _elevation = elevation,
        _aspect = aspect,
        _slopePercentage = slopePercentage,
        _slopePosition = slopePosition,
        _soilInfo = soilInfo,
        _coverType = coverType,
        _standStructure = standStructure,
        _overstoryDensity = overstoryDensity,
        _overstorySpeciesComposition = overstorySpeciesComposition,
        _understoryDensity = understoryDensity,
        _understorySpeciesComposition = understorySpeciesComposition,
        _siteHistory = siteHistory,
        _insects = insects,
        _diseases = diseases,
        _ivasives = ivasives,
        _wildlifeDamage = wildlifeDamage,
        _mistletoeUniformity = mistletoeUniformity,
        _mistletoeLocation = mistletoeLocation,
        _hawksworth = hawksworth,
        _mistletoeTreeSpecies = mistletoeTreeSpecies,
        _roadHealth = roadHealth,
        _waterHealth = waterHealth,
        _fireRisk = fireRisk,
        _otherIssues = otherIssues,
        _diagnosis = diagnosis;

  @override
  State<AreaReview> createState() => _AreaReviewState();
}

class _AreaReviewState extends State<AreaReview> {
  // State Variables ///////////////////////////////////////////////////////////
  late final DOCXConverter _docxConverter;

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    _initializeConverters();
  }

  void _initializeConverters() async {
    _docxConverter = await DOCXConverter.create();
  }

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: "${AreaReview._titlePrefix}: ${widget._name}",
      body: Column(
        children: [
          Expanded(child: _buildAreaPropertiesListView(context)),
          LayoutBuilder(builder: _bottomButtonbuilder),
        ],
      ),
    );
  }

  // Heading ///////////////////////////////////////////////////////////////////
  Widget _buildAreaPropertiesListView(BuildContext context) {
    // For now, use `ListView` instead of `ListView.builder` to give finer
    // control over order in which checklist items appear as well as allowing
    // future tweaking of appearance of certain properties (e.g. landowner
    // should be tappable to navigate to landowner, multi-valued properties may
    // be displayed in a list).
    return ListView(
      children: [
        ListTile(
          title: Text(widget._name,
              style: Theme.of(context).textTheme.headlineLarge),
        ),
        _buildAreaPropertyListTile(context, "Landowner", widget._landowner),
        _buildAreaPropertyListTile(context, "Acres", widget._acres),
        _buildAreaPropertyListTile(
            context, "Goals and Objectives", widget._goals),
        _buildAreaPropertyListTile(context, "Elevation",
            _appendUnitsToValue(widget._elevation, AreaReview._unitElevation)),
        _buildAreaPropertyListTile(context, "Aspect", widget._aspect),
        _buildAreaPropertyListTile(
            context,
            "Slope",
            _appendUnitsToValue(
                widget._slopePercentage, AreaReview._unitSlopePercentage)),
        _buildAreaPropertyListTile(
            context, "Slope Position", widget._slopePosition),
        _buildAreaPropertyListTile(
            context, "Soil Information", widget._soilInfo),
        _buildAreaPropertyListTile(context, "Cover Type", widget._coverType),
        _buildAreaPropertyListTile(
            context, "Stand Structure", widget._standStructure),
        _buildAreaPropertyListTile(
            context, "Overstory Stand Density", widget._overstoryDensity),
        _buildAreaPropertyListTile(
          context,
          "Overstory Species Composition",
          _appendUnitsToValue(widget._overstorySpeciesComposition,
              AreaReview._unitSpeciesComposition),
        ),
        _buildAreaPropertyListTile(
            context, "Understory Stand Density", widget._understoryDensity),
        _buildAreaPropertyListTile(
          context,
          "Understory Species Composition",
          _appendUnitsToValue(widget._understorySpeciesComposition,
              AreaReview._unitSpeciesComposition),
        ),
        _buildAreaPropertyListTile(
            context, "Site History", widget._siteHistory),
        _buildAreaPropertyListTile(context, "Insects", widget._insects),
        _buildAreaPropertyListTile(context, "Diseases", widget._diseases),
        _buildAreaPropertyListTile(context, "Ivasives", widget._ivasives),
        _buildAreaPropertyListTile(
            context, "Wildlife Damage", widget._wildlifeDamage),
        _buildAreaPropertyListTile(
            context, "Mistletoe Uniformity", widget._mistletoeUniformity),
        _buildAreaPropertyListTile(
            context, "Mistletoe Location", widget._mistletoeLocation),
        _buildAreaPropertyListTile(
            context, "Hawksworth Infectino Rating", widget._hawksworth),
        _buildAreaPropertyListTile(
            context, "Mistletoe Tree Species", widget._mistletoeTreeSpecies),
        _buildAreaPropertyListTile(context, "Road Health", widget._roadHealth),
        _buildAreaPropertyListTile(
            context, "Water Health", widget._waterHealth),
        _buildAreaPropertyListTile(context, "Fire Risk", widget._fireRisk),
        _buildAreaPropertyListTile(
            context, "Other Issues", widget._otherIssues),
        _buildAreaPropertyListTile(context, "Diagnosis", widget._diagnosis),
      ],
    );
  }

  /// Create a formatted string with units appended or `null` if omitted.
  ///
  /// Append the the specified [units] to given [value]. If [value] is `null`
  /// just return `null`.
  String? _appendUnitsToValue(String? value, String units) {
    return (value == null) ? null : "$value $units";
  }

  Widget _buildAreaPropertyListTile(
    BuildContext context,
    String propertyLabel,
    String? property,
  ) {
    final TextStyle? styleProperty = Theme.of(context).textTheme.headlineSmall;
    final TextStyle styleLabel =
        styleProperty!.copyWith(fontWeight: FontWeight.bold);

    return ListTile(
      // Use `Wrap` to push property down underneath the label when too long.
      title: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: [
          Text("$propertyLabel: ", style: styleLabel),
          Text(property ?? AreaReview._placeholderForOmitted,
              style: styleProperty),
        ],
      ),
    );
  }

  // Button Layout /////////////////////////////////////////////////////////////
  Widget _bottomButtonbuilder(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    if (constraints.maxWidth < BreakPoints.widthPhonePortait) {
      return Table(
        children: [
          TableRow(children: [
            _buildButtonDOCX(context),
            _buildButtonEmail(context),
          ]),
          TableRow(children: [
            _buildButtonPDF(context),
            _buildButtonEdit(context),
          ]),
          TableRow(children: [
            Container(),
            _buildButtonDelete(context),
          ]),
        ],
      );
    }

    return Row(
      children: [
        _buildButtonPDF(context),
        _buildButtonDOCX(context),
        Expanded(child: Container()),
        _buildButtonEmail(context),
        _buildButtonEdit(context),
        _buildButtonDelete(context),
      ],
    );
  }

  Widget _buildButtonEmail(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(AreaReview._buttonTextEmail),
    );
  }

  Widget _buildButtonPDF(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        // Build the PDF widget tree
        final pdf = PdfConverter().create(
          widget._name,
          widget._landowner,
          widget._acres,
          widget._goals,
          widget._elevation,
          widget._aspect,
          widget._slopePercentage,
          widget._slopePosition,
          widget._soilInfo,
          widget._coverType,
          widget._standStructure,
          widget._overstoryDensity,
          widget._overstorySpeciesComposition,
          widget._understoryDensity,
          widget._understorySpeciesComposition,
          widget._siteHistory,
          widget._insects,
          widget._diseases,
          widget._ivasives,
          widget._wildlifeDamage,
          widget._mistletoeUniformity,
          widget._mistletoeLocation,
          widget._hawksworth,
          widget._mistletoeTreeSpecies,
          widget._roadHealth,
          widget._waterHealth,
          widget._fireRisk,
          widget._otherIssues,
          widget._diagnosis,
          context.read<Settings>.toString()
          );

        // Get the path of the folder in which to store the pdf file.
        // On Android, you must access external storage in order to open the file outside of the app.
        // https://stackoverflow.com/questions/63688285/flutter-platformexceptionerror-failed-to-find-configured-root-that-contains
        final directory = await getExternalStorageDirectory();

        // Need to add an alternative if using iOS
        if (directory != null) {
          final file = File("${directory.absolute.path}/forest_wellness_checkup.pdf");
          await file.writeAsBytes(await pdf.save());
          OpenFile.open(file.path);
        } else {
          // Change this to display an error message.
          print("External storage directory is null.");
        }
      },
      child: const Text(AreaReview._buttonTextPDF),
    );
  }

  Widget _buildButtonDOCX(BuildContext context) {
    return OutlinedButton(
      onPressed: () => debugPrint("${_docxConverter.contentControlTags}\n"),
      child: const Text(AreaReview._buttonTextDOCX),
    );
  }

  Widget _buildButtonEdit(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(AreaReview._buttonTextEdit),
    );
  }

  Widget _buildButtonDelete(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(AreaReview._buttonTextDelete),
    );
  }
}
