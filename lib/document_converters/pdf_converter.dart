import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pdfWidget;

class PdfConverter {
  // Fill out the PDF template with supplied data
  // Returns a pdf object
  pdfWidget.Document create(
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
    String? evaluator,) {
    final pdf = pdfWidget.Document();
    pdf.addPage(pdfWidget.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pdfWidget.Context context) {
        return pdfWidget.Column(
          children: [
            pdfWidget.Text("Forest Wellness Checkup"),
            pdfWidget.Text("Landowner name: $landowner"),
            pdfWidget.Text("Address: "),
            pdfWidget.Text("Email: "),
            pdfWidget.Text("Stand/Area Name: $name"),
            pdfWidget.Text("Acres: $acres"),
            pdfWidget.Text("Landowner goals and objectives:"),
            pdfWidget.Text("$goals"),
            pdfWidget.Text("Site Characteristics"),
            pdfWidget.Row(
              children: [
                pdfWidget.Text("Elevation: $elevation"),
                pdfWidget.Text("Aspect: $aspect"),
                pdfWidget.Text("% Slope: $slopePercentage %"),
              ]
            ),
            // How to include checkmark options? 
            pdfWidget.Text("Slope position: $slopePosition"),
            pdfWidget.Text("Soil Information"),
            pdfWidget.Text("$soilInfo"),
            pdfWidget.Text("Vegetative Conditions"),
            pdfWidget.Text("Cover type: $coverType"),
            pdfWidget.Text("Stand structure: $standStructure"),
            pdfWidget.Text("Overstory stand density: $overstoryDensity"),
            pdfWidget.Text("Overstory species composition: $overstorySpeciesComposition %"),
            pdfWidget.Text("Understory stand density: $understoryDensity"),
            pdfWidget.Text("Understory species composition: $understorySpeciesComposition %"),
          ]
        );
      }
  ));
  pdf.addPage(pdfWidget.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pdfWidget.Context context) {
        return pdfWidget.Column(
          children: [
            pdfWidget.Text("Stand/Area History:"),
            pdfWidget.Text("$siteHistory"),
            pdfWidget.Text("Pests & Damage"),
            pdfWidget.Text("Insects Present (if known):"),
            pdfWidget.Text("$insects"),
            pdfWidget.Text("Diseases Present (if known):"),
            pdfWidget.Text("$diseases"),
            pdfWidget.Text("Invasive Plants & Animals:"),
            pdfWidget.Text("$invasives"),
            pdfWidget.Text("Wildlife Damage/Issues:"),
            pdfWidget.Text("$wildlifeDamage"),
            pdfWidget.Text("Mistletoe Infections:"),
            pdfWidget.Text("Uniformity: $mistletoeUniformity"),
            pdfWidget.Text("Mistletoe location: $mistletoeLocation"),
            pdfWidget.Text("Hawksworth infection rating(0-6): $hawksworth"),
            pdfWidget.Text("Tree species infected:"),
            pdfWidget.Text("$mistletoeTreeSpecies"),
            pdfWidget.Text("Road Health/Conditions:"),
          ]
        );
      }
    )
  );
  pdf.addPage(pdfWidget.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pdfWidget.Context context) {
        return pdfWidget.Column(
          children: [
            pdfWidget.Text("Road Health/Conditions:"),
            pdfWidget.Text("$roadHealth"),
            pdfWidget.Text("Water/Stream/Riparian Health & Issues:"),
            pdfWidget.Text("$waterHealth"),
            pdfWidget.Text("Fire Risk (fuel levels & ignition potential):"),
            pdfWidget.Text("$fireRisk"),
            pdfWidget.Text("Other issues (explain):"),
            pdfWidget.Text("$otherIssues"),
            pdfWidget.Text("Diagnosis & Suggestions"),
            pdfWidget.Text("$diagnosis"),
            pdfWidget.Text("Evaluator name: $evaluator"),
            pdfWidget.Text("Email: "),
            pdfWidget.Text("Address: "),
          ]
        );
      }
    )
  );
    return pdf;
  }
}