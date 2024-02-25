import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner.dart";
import 'package:forestryapp/models/settings.dart';
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;

/// Fills out the PDF template and returns a pdf object
class PdfConverter {
  pw.Document create(Area area, Landowner landowner, Settings evaluator,) {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (context) => _buildHeader0(context),
      build: (pw.Context context) {
        return [
          _buildKeyValue(context, "Landowner name", ""),
          _buildKeyValue(context, "Address", ""),
          _buildKeyValue(context, "Email", ""),
          _buildKeyValue(context, "Stand/Area Name", area.name),
          _buildKeyValue(context, "Acres", area.acres.toString()),
          _buildHeader2(context, "Landowner goals and objectives:"),
          pw.Paragraph(text: area.goals),
          _buildHeader1(context, "Site Characteristics"),
          pw.Row(
            children: [
              _buildKeyValue(context, "Elevation", area.elevation.toString()),
              _buildKeyValue(context, "Aspect", area.aspect.label),
              _buildKeyValue(context, "% Slope", "${area.slopePercentage} %"),
            ]
          ),
          // How to include checkmark options?
          _buildKeyValue(context, "Slope position", area.slopePosition.label),
          _buildHeader2(context, "Soil Information"),
          pw.Paragraph(text: area.soilInfo),
          _buildHeader1(context, "Vegetative Conditions"),
          _buildKeyValue(context, "Cover type", area.coverType.label),
          _buildKeyValue(context, "Stand structure", area.standStructure.label),
          _buildKeyValue(context, "Overstory stand density", area.overstoryDensity.label),
          _buildKeyValue(context, "Overstory species composition", "${area.overstorySpeciesComposition} %"),
          _buildKeyValue(context, "Understory stand density", area.understoryDensity.label),
          _buildKeyValue(context, "Understory species composition", "${area.understorySpeciesComposition} %"),
          _buildHeader2(context, "Stand/Area History:"),
          pw.Paragraph(text: area.standHistory),
          _buildHeader1(context, "Pests & Damage"),
          _buildHeader2(context, "Insects Present (if known):"),
          pw.Paragraph(text: area.insects),
          _buildHeader2(context, "Diseases Present (if known):"),
          pw.Paragraph(text: area.diseases),
          _buildHeader2(context, "Invasive Plants & Animals:"),
          pw.Paragraph(text: area.invasives),
          _buildHeader2(context, "Wildlife Damage/Issues:"),
          pw.Paragraph(text: area.wildlifeDamage),
          _buildHeader2(context, "Mistletoe Infections:"),
          _buildKeyValue(context, "Uniformity", area.mistletoeUniformity.label),
          _buildKeyValue(context, "Mistletoe location", area.mistletoeLocation),
          _buildKeyValue(context, "Hawksworth infection rating(0-6)", area.hawksworth.label),
          _buildHeader2(context, "Tree species infected"),
          pw.Paragraph(text: area.mistletoeTreeSpecies),
          _buildHeader2(context, "Road Health/Conditions:"),
          pw.Paragraph(text: area.roadHealth),
          _buildHeader2(context, "Water/Stream/Riparian Health & Issues:"),
          pw.Paragraph(text: area.waterHealth),
          _buildHeader2(context, "Fire Risk (fuel levels & ignition potential):"),
          pw.Paragraph(text: area.fireRisk),
          _buildHeader2(context, "Other issues (explain):"),
          pw.Paragraph(text: area.otherIssues),
          _buildHeader2(context, "Diagnosis & Suggestions"),
          pw.Paragraph(text: area.diagnosis),
          _buildKeyValue(context, "Evaluator name", evaluator.evaluatorName),
          _buildKeyValue(context, "Email", evaluator.evaluatorEmail),
          _buildKeyValue(context, "Address", evaluator.combinedAddress),
        ];
      }
    ));

    return pdf;
  }

  pw.Widget _buildHeader0(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 16.0),
          child: pw.Text(
            "Forest Wellness Checkup", 
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 16.0,
              fontWeight: pw.FontWeight.bold,
            )
          ),
        )
      ],
    );
  }

  pw.Widget _buildHeader1(pw.Context context, String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 14.0),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 14.0,
          fontWeight: pw.FontWeight.bold,
        )
      )
    );
  }

  pw.Widget _buildHeader2(pw.Context context, String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 12.0),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 12.0,
          fontWeight: pw.FontWeight.bold,
        )
      )
    );
  }

  /// Display the heading(key) and corresponding value on a single line
  pw.Widget _buildKeyValue(pw.Context context, String key, String? value) {
    return pw.RichText(
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
    );
  }
}