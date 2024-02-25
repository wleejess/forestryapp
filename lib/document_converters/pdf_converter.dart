import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner.dart";
import 'package:forestryapp/models/settings.dart';
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;

/// Fills out the PDF template and returns a pdf object
class PdfConverter {
  pw.Document create(Area area, Landowner landowner, Settings evaluator,) {
    final pdf = pw.Document(
      theme: pw.ThemeData(
        defaultTextStyle: const pw.TextStyle(
          fontSize: 10.0,
        ),
        paragraphStyle: const pw.TextStyle(
          fontSize: 10.0,
        ),
      ),
    );

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (context) => _buildHeader0(context),
      build: (pw.Context context) {
        return [
          _buildKeyValue(context, "Landowner name", landowner.name),
          _buildKeyValue(context, "Address", landowner.address),
          _buildKeyValue(context, "Email", landowner.email),
          _buildKeyValue(context, "Stand/Area Name", area.name),
          _buildKeyValue(context, "Acres", area.acres.toString()),
          _buildHeader1(context, "Landowner goals and objectives:"),
          _buildParagraph(context, area.goals),
          _buildHeader1(context, "Site Characteristics"),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildKeyValue(context, "Elevation", area.elevation.toString()),
              _buildKeyValue(context, "Aspect", area.aspect.label),
              _buildKeyValue(context, "% Slope", "${area.slopePercentage} %"),
            ]
          ),
          // How to include checkmark options?
          _buildKeyValue(context, "Slope position", area.slopePosition.label),
          pw.SizedBox(height: 10),
          _buildHeader2(context, "Soil Information"),
          _buildParagraph(context, area.soilInfo),
          _buildHeader1(context, "Vegetative Conditions"),
          _buildKeyValue(context, "Cover type", area.coverType.label),
          _buildKeyValue(context, "Stand structure", area.standStructure.label),
          _buildKeyValue(context, "Overstory stand density", area.overstoryDensity.label),
          _buildKeyValue(context, "Overstory species composition", "${area.overstorySpeciesComposition} %"),
          _buildKeyValue(context, "Understory stand density", area.understoryDensity.label),
          _buildKeyValue(context, "Understory species composition", "${area.understorySpeciesComposition} %"),
          _buildHeader2(context, "Stand/Area History:"),
          _buildParagraph(context, area.standHistory),
          _buildHeader1(context, "Pests & Damage"),
          _buildHeader2(context, "Insects Present (if known):"),
          _buildParagraph(context, area.insects),
          _buildHeader2(context, "Diseases Present (if known):"),
          _buildParagraph(context, area.diseases),
          _buildHeader2(context, "Invasive Plants & Animals:"),
          _buildParagraph(context, area.invasives),
          _buildHeader2(context, "Wildlife Damage/Issues:"),
          _buildParagraph(context, area.wildlifeDamage),
          _buildHeader2(context, "Mistletoe Infections:"),
          _buildKeyValue(context, "Uniformity", area.mistletoeUniformity.label),
          _buildKeyValue(context, "Mistletoe location", area.mistletoeLocation),
          _buildKeyValue(context, "Hawksworth infection rating(0-6)", area.hawksworth.label),
          _buildHeader2(context, "Tree species infected"),
          _buildParagraph(context, area.mistletoeTreeSpecies),
          _buildHeader1(context, "Road Health/Conditions:"),
          _buildParagraph(context, area.roadHealth),
          _buildHeader1(context, "Water/Stream/Riparian Health & Issues:"),
          _buildParagraph(context, area.waterHealth),
          _buildHeader1(context, "Fire Risk (fuel levels & ignition potential):"),
          _buildParagraph(context, area.fireRisk),
          _buildHeader1(context, "Other issues (explain):"),
          _buildParagraph(context, area.otherIssues),
          // Create a line
          pw.Header(text: "", level: 0),
          _buildHeader1(context, "Diagnosis & Suggestions"),
          _buildParagraph(context, area.diagnosis),
          _buildKeyValue(context, "Evaluator name", evaluator.evaluatorName),
          _buildKeyValue(context, "Email", evaluator.evaluatorEmail),
          _buildKeyValue(context, "Address", evaluator.combinedAddress),
        ];
      }
    ));

    return pdf;
  }

  /// Display the main heading
  pw.Widget _buildHeader0(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 13.0),
          child: pw.Text(
            "Forest Wellness Checkup", 
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 13.0,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex("#808080"),
            )
          ),
        )
      ],
    );
  }

  /// Display a first-level heading
  pw.Widget _buildHeader1(pw.Context context, String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 11),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 11.0,
          fontWeight: pw.FontWeight.bold,
        )
      )
    );
  }

  /// Display a second level heading
  pw.Widget _buildHeader2(pw.Context context, String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
        )
      )
    );
  }

  /// Display the heading(key) and corresponding value on a single line
  pw.Widget _buildKeyValue(pw.Context context, String key, String? value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2.0),
      child: pw.RichText(
        text: pw.TextSpan(
          text: key,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
          children: [
            const pw.TextSpan(
              text: ": ",
            ),
            pw.TextSpan(
              text: value,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.normal,
              )
            )
          ]
        ),
      )
    );
  }

  pw.Widget _buildParagraph(pw.Context context, text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Text(
        "$text",
        style: pw.Theme.of(context).paragraphStyle,
      )
    );
  }
}