import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/bottom_button_builder.dart";
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/models/area.dart";
import "package:provider/provider.dart";

/// The FormReview page allows the user to review the data they have
/// entered into the Area form screens before saving it. Validations errors
/// appear alongside the entered data. If there are errors, the save,
/// PDF, and DOCX buttons are disabled.
class FormReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Summary";
  static const _buttonTextPDF = "Create PDF";
  static const _buttonTextDOCX = "Create DOCX";
  static const _buttonTextCancel = "Cancel";

  // Constructor ///////////////////////////////////////////////////////////////
  const FormReview({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<Area>(context);
    List<Widget> buttons = [
      _buildButtonPDF(context),
      _buildButtonDOCX(context),
      _buildButtonCancel(context)
    ];

    return ForestryScaffold(
      title: _titlePrefix, // TODO: Needs validation
      body: Column(
        children: [
          Expanded(child: AreaProperties(formData)),
          LayoutBuilder(
            builder: (context, constraints) {
              return BottomButtonBuilder().builder(context, constraints, formData, buttons);
            },
          ),
        ],
      )
    );
  }

  Widget _buildButtonPDF(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonTextPDF),
    );
  }

  Widget _buildButtonDOCX(BuildContext context) {
    final DOCXConverter docxConverter = Provider.of<DOCXConverter>(context);
    return OutlinedButton(
      onPressed: () => debugPrint("${docxConverter.contentControlTags}\n"),
      child: const Text(_buttonTextDOCX),
    );
  }

  Widget _buildButtonCancel(BuildContext context) {
    return OutlinedButton(
      onPressed: () => {
        // TODO: Clear the Area provider and navigate out of the form section.
      }, 
      child: const Text(_buttonTextCancel),
    );
  }

}
