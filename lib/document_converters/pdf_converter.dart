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
    String? diagnosis,) {
    final pdf = pdfWidget.Document();
    pdf.addPage(pdfWidget.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pdfWidget.Context context) {
        return pdfWidget.Column(
          children: [
            pdfWidget.Text("Forest Wellness Checkup"),
          ]
        );
      }
    ));
    return pdf;
  }
}