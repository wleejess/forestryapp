import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/docx_button.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/bottom_button_builder.dart";
import "package:forestryapp/database/dao_area.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/screens/area_index.dart";
import "package:forestryapp/screens/area_review.dart";
import "package:provider/provider.dart";
import "package:sqflite/sqflite.dart";

/// The FormReview page allows the user to review the data they have
/// entered into the Area form screens before saving it. Validations errors
/// appear alongside the entered data. If there are errors, the save,
/// PDF, and DOCX buttons are disabled.
class FormReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Summary";
  static const _buttonTextPDF = "Create PDF";
  static const _buttonTextSave = "Save";
  static const _buttonTextCancel = "Cancel";
  static const _scaffoldMessageSaveSuccess = "Area Saved!";

  static const _defaultAlertButtonText = "OK";
  static const _failedToSaveAreaTitle = "Database Error";
  static const _failedToSaveAreaMessage = "Failed To Save Area";
  static const _consoleSeparator =
      '--------------------------------------------------------------------------------';

  // Constructor ///////////////////////////////////////////////////////////////
  const FormReview({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<Area>(context);
    final landowner =
        Provider.of<LandownerCollection>(context).getByID(formData.landownerID);

    List<Widget> buttons = [
      _buildButtonPDF(context),
      DOCXButton(formData, landowner),
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
    final formArea = Provider.of<Area>(context, listen: false);

    // TODO: add condition for validation and return immediately if it fails.

    try {
      // If this throws an exception is is likely due to the Area Provider
      // having invalid values that fail the "CHECK" conditions present in
      // "assets/database/schema/areas.sql".
      await _saveArea(context, formArea);
    } on DatabaseException catch (e) {
      if (!context.mounted) return;
      _alert(
        context: context,
        title: _failedToSaveAreaTitle,
        message: _failedToSaveAreaMessage,
        exceptionToPrintToConsole: e,
      );
      return;
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          _scaffoldMessageSaveSuccess,
          textAlign: TextAlign.center,
        ),
      ),
    );

    _navigateAfterSave(context, formArea);
  }

  Future<void> _saveArea(BuildContext context, Area formArea) async {
    debugPrint('$formArea');

    if (formArea.id == null) {
      formArea.id = await DAOArea.saveNewArea(formArea);
    } else {
      await DAOArea.updateExistingArea(formArea);
    }

    if (!context.mounted) return;
    await Provider.of<LandownerCollection>(context, listen: false).refetch();
    if (!context.mounted) return;
    await Provider.of<AreaCollection>(context, listen: false).refetch();
    if (!context.mounted) return;
  }

  /// Present an AlertDialog to the user.
  ///
  /// Displays an AlertDialog with a single button that when clicked makes the
  /// dialog disappear. Can optionally take [exceptionToPrintToConsole] to print
  /// its contents to console for debugging purposes.
  void _alert({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = _defaultAlertButtonText,
    Exception? exceptionToPrintToConsole,
  }) {
    // Don't show the exception to the user. It could be quite long and cryptic.
    // For instance it would include an entire SQLite DDL statement.
    if (exceptionToPrintToConsole != null) {
      debugPrint("$_consoleSeparator\n$exceptionToPrintToConsole");
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(message)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonText),
          )
        ],
      ),
    );
  }

  void _navigateAfterSave(context, formArea) {
    final Widget Function(BuildContext) destination;

    // ASSUMPTION: Area Provider ID should be set for (1) newly created areas
    // from `_saveArea` and (2) already set for areas being updated. Hence the
    // `else` is just a safeguard to fail elegantly if for some reason the ID is
    // not set.
    if (formArea.id != null) {
      destination = (context) => AreaReview(formArea.id);
    } else {
      destination = (context) => const AreaIndex();
    }

    Navigator.push(context, MaterialPageRoute(builder: destination));
  }
}
