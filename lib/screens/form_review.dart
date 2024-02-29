import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/landowner.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/util/break_points.dart";
import "package:provider/provider.dart";

/// The FormReview page allows the user to review the data they have
/// entered into the Area form screens before saving it. Validations errors
/// appear alongside the entered data. If there are errors, the save,
/// PDF, and DOCX buttons are disabled.
class FormReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";
  static const _buttonTextSave = "Save";
  static const _buttonTextPDF = "Create PDF";
  static const _buttonTextDOCX = "Create DOCX";
  static const _buttonTextCancel = "Cancel";

  // Constructor ///////////////////////////////////////////////////////////////
  const FormReview({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<Area>(context);

    return ForestryScaffold(
      title: "$_titlePrefix: ${formData.name}", // TODO: Needs validation
      body: Column(
        children: [
          Expanded(child: AreaProperties(formData)),
          LayoutBuilder(
            builder: (context, contraints) {
              return _bottomButtonbuilder(context, contraints, formData);
            },
          ),
        ],
      )
    );
  }

  // Button Layout /////////////////////////////////////////////////////////////
  Widget _bottomButtonbuilder(
    BuildContext context,
    BoxConstraints constraints,
    Area area,
  ) {
    // ignore: unused_local_variable
    final Landowner? landowner =
        Provider.of<LandownerCollection>(context).landownerOfReviewedArea;

    if (constraints.maxWidth < BreakPoints.widthPhonePortait) {
      return Table(
        children: [
          TableRow(children: [
            _buildButtonSave(context,)
          ]),
          TableRow(children: [
            _buildButtonDOCX(context),
          ]),
          TableRow(children: [
            _buildButtonPDF(context),
          ]),
          TableRow(children: [
            Container(),
            _buildButtonCancel(context),
          ]),
        ],
      );
    }

    return Row(
      children: [
        _buildButtonSave(context),
        _buildButtonPDF(context),
        _buildButtonDOCX(context),
        Expanded(child: Container()),
        _buildButtonCancel(context),
      ],
    );
  }

  Widget _buildButtonSave(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonTextSave),
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
        // TODO: Clear the Area provider, navigate out of the form
      },
      child: const Text(_buttonTextCancel),
    );
  }
}
