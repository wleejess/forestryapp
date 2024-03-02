import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/bottom_button_builder.dart";
import "package:forestryapp/document_converters/docx_converter.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/models/landowner_collection.dart";
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
  static const _buttonTextSave = "Save";
  static const _buttonTextCancel = "Cancel";
  static const _scaffoldMessageSaveSuccess = "Area Saved!";

  // Constructor ///////////////////////////////////////////////////////////////
  const FormReview({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<Area>(context);
    List<Widget> buttons = [
      _buildButtonPDF(context),
      _buildButtonDOCX(context),
      _buildButtonSave(context),
      _buildButtonCancel(context)
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

  Widget _buildButtonSave(BuildContext context) {
    return OutlinedButton(
      onPressed: () async => await _pressSaveButton(context),
      child: const Text(_buttonTextSave),
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

  // Writing To Database ///////////////////////////////////////////////////////
  Future<void> _pressSaveButton(BuildContext context) async {
    // TODO: add condition for validation and return immediately if it fails.

    await _saveArea(context);

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          _scaffoldMessageSaveSuccess,
          textAlign: TextAlign.center,
        ),
      ),
    );
    // TODO: Navigate to AreaReview
  }

  Future<void> _saveArea(BuildContext context) async {
    final formArea = Provider.of<Area>(context, listen: false);

    debugPrint('$formArea');

    if (formArea.id == null) {
      debugPrint("TODO: Insert new record into `areas` table.");
    } else {
      debugPrint("TODO: Update existing record in `areas` table.");
    }

    await Provider.of<LandownerCollection>(context, listen: false).refetch();
    if (!context.mounted) return;
    await Provider.of<AreaCollection>(context, listen: false).refetch();
    if (!context.mounted) return;
  }
}
