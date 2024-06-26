import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/cancel_form_summary_button.dart";
import "package:forestryapp/components/docx_button.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/bottom_button_builder.dart";
import "package:forestryapp/components/pdf_button.dart";
import "package:forestryapp/components/save_button.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:provider/provider.dart";

/// The FormReview page allows the user to review the data they have
/// entered into the Area form screens before saving it. Validations errors
/// appear alongside the entered data. If there are errors, the save,
/// PDF, and DOCX buttons are disabled.
class FormReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Summary";

  // Constructor ///////////////////////////////////////////////////////////////
  const FormReview({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<Area>(context);
    final landowner =
        Provider.of<LandownerCollection>(context).getByID(formData.landownerID);

    List<Widget> buttons = [
      PdfButton(area: formData, landowner: landowner),
      DOCXButton(formData, landowner),
      const SaveButton(),
      const CancelFormSummaryButton(),
    ];

    return ForestryScaffold(
        showFormLinks: true,
        title: _titlePrefix, // TODO: Needs validation
        body: Column(
          children: [
            Expanded(child: AreaProperties(formData)),
            LayoutBuilder(
              builder: (context, constraints) {
                return BottomButtonBuilder()
                    .builder(context, constraints, formData, buttons);
              },
            ),
          ],
        ));
  }
}
