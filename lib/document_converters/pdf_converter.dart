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
          // Basic information
          _buildKeyValue(context, "Landowner name", landowner.name),
          _buildKeyValue(context, "Address", landowner.address),
          _buildKeyValue(context, "Email", landowner.email),
          _buildKeyValue(context, "Stand/Area Name", area.name),
          _buildKeyValue(context, "Acres", area.acres.toString()),
          _buildHeader1(context, "Landowner goals and objectives:"),
          _buildParagraph(context, area.goals),

          // Site Characteristics
          _buildHeader1(context, "Site Characteristics"),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildKeyValue(context, "Elevation", area.elevation.toString()),
              _buildKeyValue(context, "Aspect", area.aspect.label),
              _buildKeyValue(context, "% Slope", "${area.slopePercentage} %"),
            ]
          ),
          _buildKeyValue(context, "Slope position", area.slopePosition.label),
          pw.SizedBox(height: 10),
          _buildHeader2(context, "Soil Information"),
          _buildParagraph(context, area.soilInfo),

          // Vegetative Conditions
          _buildHeader1(context, "Vegetative Conditions"),
          _buildKeyValue(context, "Cover type", area.coverType.label),
          _buildKeyValue(context, "Stand structure", area.standStructure.label),
          _buildKeyValue(context, "Overstory stand density", area.overstoryDensity.label),
          _buildKeyValue(context, "Overstory species composition", "${area.overstorySpeciesComposition} %"),
          _buildKeyValue(context, "Understory stand density", area.understoryDensity.label),
          _buildKeyValue(context, "Understory species composition", "${area.understorySpeciesComposition} %"),
          _buildHeader2(context, "Stand/Area History:"),
          _buildParagraph(context, area.standHistory),

          // Damages
          _buildHeader1(context, "Pests & Damage"),
          _buildHeader2(context, "Insects Present (if known):"),
          _buildParagraph(context, area.insects),
          _buildHeader2(context, "Diseases Present (if known):"),
          _buildParagraph(context, area.diseases),
          _buildHeader2(context, "Invasive Plants & Animals:"),
          _buildParagraph(context, area.invasives),
          _buildHeader2(context, "Wildlife Damage/Issues:"),
          _buildParagraph(context, area.wildlifeDamage),

          // Mistletoe
          _buildHeader2(context, "Mistletoe Infections:"),
          _buildKeyValue(context, "Uniformity", area.mistletoeUniformity.label),
          _buildKeyValue(context, "Mistletoe location", area.mistletoeLocation),
          _buildKeyValue(context, "Hawksworth infection rating(0-6)", area.hawksworth.label),
          _buildHeader2(context, "Tree species infected"),
          _buildParagraph(context, area.mistletoeTreeSpecies),

          // Free Response
          _buildHeader1(context, "Road Health/Conditions:"),
          _buildParagraph(context, area.roadHealth),
          _buildHeader1(context, "Water/Stream/Riparian Health & Issues:"),
          _buildParagraph(context, area.waterHealth),
          _buildHeader1(context, "Fire Risk (fuel levels & ignition potential):"),
          _buildParagraph(context, area.fireRisk),
          _buildHeader1(context, "Other issues (explain):"),
          _buildParagraph(context, area.otherIssues),

          // Use Header() to create a line break before the conclusion
          pw.Header(text: "", level: 0),
          _buildHeader1(context, "Diagnosis & Suggestions"),
          _buildParagraph(context, area.diagnosis),
          _buildKeyValue(context, "Evaluator name", evaluator.evaluatorName),
          _buildKeyValue(context, "Email", evaluator.evaluatorEmail),
          _buildKeyValue(context, "Address", evaluator.combinedAddress),
          
          // Section on How to fill out the form
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 13.0),
                child: pw.Text(
                  "How to Fill Out Wellness Checkup Form", 
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 13.0,
                    fontWeight: pw.FontWeight.bold,
                  )
                ),
              )
            ],
          ),
          _buildKeyValue(context, "Landowner Name", "Write in the landowner's name(s).", isItalic: true),
          _buildKeyValue(context, "Address/email", 
            "Write in their physical and/or email addresses. You should be able "
            "to mail or email this form to the landowner after it is filled out.", 
            isItalic: true),
          _buildKeyValue(context, "Stand/Area Name", 
            "For each area or unit you visit, write in the name of the area that "
            "the landowner uses or make one up that is descriptive (meadow, young DF stand, etc.).", 
            isItalic: true),
          _buildKeyValue(context, "Acres", "Write in the approximate acres for each stand or area.", isItalic: true),
          _buildKeyValue(context, "Elevation", "Write in the elevation, if known.", isItalic: true),
          _buildKeyValue(context, "Aspect", 
            "Write in the direction the stand or area faces (N, NE, E, SE, S, SW, W, NW).", 
            isItalic: true),
          _buildKeyValue(context, "% Slope", "Write in the approximate or average percent slope.", isItalic: true),
          _buildKeyValue(context, "Slope position", 
            "Check off whether the area is on a lower, middle, upper, or ridgetop position.", 
            isItalic: true),
          _buildKeyValue(context, "Soil Information", 
            "Add any information about the soils that is available to you from either the "
            "landowner or obtain it online and add this information after your visit.", 
            isItalic: true),
          _buildKeyValue(context, "Cover type", 
            "forest, meadow, wetland, rangeland, juniper woodlands, etc.", isItalic: true),
          _buildKeyValue(context, "Stand Structure", 
            "Check off whether the stand or area is even-aged, two-aged, or multi-aged.", isItalic: true),
          _buildKeyValue(context, "Overstory stand density", 
            "Check off whether stand density is low, medium, or high. This is a qualitative judgement.", 
            isItalic: true),
          _buildKeyValue(context, "Overstory species composition", 
            "Write in the approximate overstory tree species percentages.", isItalic: true),
          _buildKeyValue(context, "Understory stand density", 
            "Check off whether understory stand density is low, medium, or high. This is a "
            "qualitative judgement and pertains mostly to two-aged and multi-aged stands.", 
            isItalic: true),
          _buildKeyValue(context, "Understory species composition", 
            "Write in the approximate understory tree species percentages.", isItalic: true),
          _buildKeyValue(context, "Stand/Area history", 
            "Describe prior management activities and/or disturbances that have shaped or "
            "influenced the stand as it appears today.", isItalic: true),
          _buildKeyValue(context, "Insects Present", 
            "If past or present insect damage is apparent in the stand or area, "
            "list the insects observed, if known.", isItalic: true),
          _buildKeyValue(context, "Diseases Present", 
            "If past or present disease damage is apparent in the stand or area, "
            "list diseases observed, if known. ", isItalic: true),
          _buildKeyValue(context, "Invasive Plants & Animals", 
            "List any invasive plants or animals observed by the evaluator or landowner.", isItalic: true),
          _buildKeyValue(context, "Wildlife Damage/Issues", 
            "Describe wildlife damage to tree seedlings, saplings or mature trees. If regeneration "
            "is damaged, estimate the percentage of seedlings/saplings affected.", 
            isItalic: true),
          _buildKeyValue(context, "Mistletoe Infections", 
            "Check whether mistletoe infections are isolated/grouped or whether it is, "
            "more or less, uniform throughout the stand or area.", 
            isItalic: true),
          _buildKeyValue(context, "Hawksworth infection rating", 
            "Rate the mistletoe infection level and check the appropriate rating. If you are "
            "not familiar with this rating system and how to do it, write your observations "
            "elsewhere, such under 'Diagnosis & Suggestions.'", 
            isItalic: true),
          _buildKeyValue(context, "Tree species infected", 
            "List the tree species infected with mistletoe.", isItalic: true),
          _buildKeyValue(context, "Other issues", 
            "Describe any other health related issues you observed.", isItalic: true),
          _buildKeyValue(context, "Road Health/Condition", 
            "Make note of any road related problems for the stand or area. This could include erosion, "
            "slumps, sediment delivery into streams or other waterways, culvert & ditch problems, etc.", 
            isItalic: true),
          _buildKeyValue(context, "Water/Stream/Riparian Health & Issues", 
            "Make note of any issues related to water, streams, springs in the stand or area. "
            "Erosion, head cutting, cattle grazing effects, sedimentation, culverts, ditches, etc.", 
            isItalic: true),
          _buildKeyValue(context, "Fire Risk (fuel levels & ignition potential)", 
            "Note the level of fuel on the ground (high, medium, low) and the density and structure of "
            "the forest in the stand or area. Are there abundant ladder fuels? What is the potential "
            "for ignition? Is the stand or area near WUI, roads, railroads, etc. where the potential "
            "for ignition is high?", isItalic: true),
          _buildKeyValue(context, "Diagnosis & Suggestions", 
            "Outline or list any issues or problems you see for the stand or area. Provide ideas "
            "for action, if needed. Help prioritize what those actions might be for the landowner. "
            "Should the actions occur sooner (now or in the immediate future) or later "
            "(next year or beyond)? Provide a list of resources to refer the landowner to and/or "
            "provide other agencies that might be able to help them take action on a particular problem.", 
            isItalic: true),
          _buildKeyValue(context, "Evaluator's Name", "Write your name(s).", isItalic: true),
          _buildKeyValue(context, "Contract info", 
            "Provide your contact info, including your email address.", isItalic: true),
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
  /// The TextSpan widget allows for inline text with varied styling
  /// The font style of the value can be optionally changed.
  pw.Widget _buildKeyValue(pw.Context context, String key, String? value, {bool isItalic = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2.0),
      child: pw.RichText(
        // Heading or "key" text
        text: pw.TextSpan(
          text: key,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
          children: [
            const pw.TextSpan(
              text: ": ",
            ),
            // Value text
            pw.TextSpan(
              text: value,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.normal,
                fontStyle: () { 
                  // Optionally allow italic value text
                  if (isItalic) {
                    return pw.FontStyle.italic;
                  } else {
                    return pw.FontStyle.normal;
                  }
                 } ()
              )
            )
          ]
        ),
      )
    );
  }

  /// Display a paragraph of text.
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
