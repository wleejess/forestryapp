import 'package:forestryapp/models/settings.dart';
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pdf_widget;

class PdfConverter {
  final heading1 = pdf_widget.TextStyle(
    fontSize: 16.00,
    fontWeight: pdf_widget.FontWeight.bold
  );

  final heading2 = pdf_widget.TextStyle(
    fontSize: 14.00,
    fontWeight: pdf_widget.FontWeight.bold
  );

  final heading3 = pdf_widget.TextStyle(
    fontSize: 12.00,
    fontWeight: pdf_widget.FontWeight.bold
  );

  // Fill out the PDF template with supplied data
  // Returns a pdf object
  pdf_widget.Document create(
    String name,
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
    String? invasives,
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
    Settings evaluator,) {
    final pdf = pdf_widget.Document();
    pdf.addPage(pdf_widget.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pdf_widget.Context context) {
        return 
        pdf_widget.Column(
          children: [
            pdf_widget.Text("Forest Wellness Checkup", style: heading1),
            pdf_widget.Column(
              crossAxisAlignment: pdf_widget.CrossAxisAlignment.start,
              children: [
                pdf_widget.Text("Landowner name: $landowner"),
                pdf_widget.Text("Address: "),
                pdf_widget.Text("Email: "),
                pdf_widget.Text("Stand/Area Name: $name"),
                pdf_widget.Text("Acres: $acres"),
                pdf_widget.Text("Landowner goals and objectives:", style: heading3),
                pdf_widget.Text("$goals"),
                pdf_widget.Text("Site Characteristics", style: heading2),
                pdf_widget.Row(
                  children: [
                    pdf_widget.Text("Elevation: $elevation"),
                    pdf_widget.Text("Aspect: $aspect"),
                    pdf_widget.Text("% Slope: $slopePercentage %"),
                  ]
                ),
                // How to include checkmark options? 
                pdf_widget.Text("Slope position: $slopePosition"),
                pdf_widget.Text("Soil Information", style: heading3),
                pdf_widget.Text("$soilInfo"),
                pdf_widget.Text("Vegetative Conditions", style: heading2),
                pdf_widget.Text("Cover type: $coverType"),
                pdf_widget.Text("Stand structure: $standStructure"),
                pdf_widget.Text("Overstory stand density: $overstoryDensity"),
                pdf_widget.Text("Overstory species composition: $overstorySpeciesComposition %"),
                pdf_widget.Text("Understory stand density: $understoryDensity"),
                pdf_widget.Text("Understory species composition: $understorySpeciesComposition %"),
              ]
            )
          ]
        );
      }
  ));
  pdf.addPage(pdf_widget.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pdf_widget.Context context) {
        return pdf_widget.Column(
          crossAxisAlignment: pdf_widget.CrossAxisAlignment.start,
          children: [
            pdf_widget.Text("Stand/Area History:", style: heading3),
            pdf_widget.Text("$siteHistory"),
            pdf_widget.Text("Pests & Damage", style: heading2),
            pdf_widget.Text("Insects Present (if known):", style: heading3),
            pdf_widget.Text("$insects"),
            pdf_widget.Text("Diseases Present (if known):", style: heading3),
            pdf_widget.Text("$diseases"),
            pdf_widget.Text("Invasive Plants & Animals:", style: heading3),
            pdf_widget.Text("$invasives"),
            pdf_widget.Text("Wildlife Damage/Issues:", style: heading3),
            pdf_widget.Text("$wildlifeDamage"),
            pdf_widget.Text("Mistletoe Infections:", style: heading3),
            pdf_widget.Text("Uniformity: $mistletoeUniformity"),
            pdf_widget.Text("Mistletoe location: $mistletoeLocation"),
            pdf_widget.Text("Hawksworth infection rating(0-6): $hawksworth"),
            pdf_widget.Text("Tree species infected:"),
            pdf_widget.Text("$mistletoeTreeSpecies"),
          ]
        );
      }
    )
  );
  pdf.addPage(pdf_widget.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pdf_widget.Context context) {
        return pdf_widget.Column(
          crossAxisAlignment: pdf_widget.CrossAxisAlignment.start,
          children: [
            pdf_widget.Text("Road Health/Conditions:", style: heading3),
            pdf_widget.Text("$roadHealth"),
            pdf_widget.Text("Water/Stream/Riparian Health & Issues:", style: heading3),
            pdf_widget.Text("$waterHealth"),
            pdf_widget.Text("Fire Risk (fuel levels & ignition potential):", style: heading3),
            pdf_widget.Text("$fireRisk"),
            pdf_widget.Text("Other issues (explain):", style: heading3),
            pdf_widget.Text("$otherIssues"),
            pdf_widget.Text("Diagnosis & Suggestions", style: heading3),
            pdf_widget.Text("$diagnosis"),
            pdf_widget.Text("Evaluator name: ${evaluator.evaluatorName}"),
            pdf_widget.Text("Email: ${evaluator.evaluatorEmail}"),
            pdf_widget.Text("Address: ${evaluator.combinedAddress}"),
          ]
        );
      }
    )
  );
    return pdf;
  }
}