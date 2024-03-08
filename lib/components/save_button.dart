import 'package:flutter/material.dart';
import 'package:forestryapp/models/area.dart';
import "package:forestryapp/database/dao_area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:forestryapp/models/landowner_collection.dart";
import "package:forestryapp/screens/area_index.dart";
import "package:forestryapp/screens/area_review.dart";
import 'package:forestryapp/components/unsaved_changes.dart';
import "package:provider/provider.dart";
import "package:sqflite/sqflite.dart";

class SaveButton extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _buttonTextSave = Text("Save");
  static const _scaffoldMessageSaveSuccess = "Area Saved!";
  static const _defaultAlertButtonText = "OK";
  static const _failedToSaveAreaTitle = "Database Error";
  static const _failedToSaveAreaMessage = "Failed To Save Area";
  static const _consoleSeparator =
      '--------------------------------------------------------------------------------';

  // Constructor ///////////////////////////////////////////////////////////////
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async => await _pressSaveButton(context),
      child: _buttonTextSave,
    );
  }

  Future<void> _pressSaveButton(BuildContext context) async {
    final formArea = Provider.of<Area>(context, listen: false);
    final unsavedChangesNotifier =
        Provider.of<UnsavedChangesNotifier>(context, listen: false);

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

    unsavedChangesNotifier.setUnsavedChanges(false); // Resetting to false here

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(_scaffoldMessageSaveSuccess, textAlign: TextAlign.center),
      ),
    );

    _navigateAfterSave(context, formArea);
  }

  Future<void> _saveArea(BuildContext context, Area formArea) async {
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

  void _navigateAfterSave(context, Area formArea) {
    final id = formArea.id;
    final Widget Function(BuildContext) destination;

    // ASSUMPTION: Area Provider ID should be set for (1) newly created areas
    // from `_saveArea` and (2) already set for areas being updated. Hence the
    // `else` is just a safeguard to fail elegantly if for some reason the ID is
    // not set.
    if (id != null) {
      destination = (context) => AreaReview(id);
    } else {
      destination = (context) => const AreaIndex();
    }

    Navigator.push(context, MaterialPageRoute(builder: destination));
  }
}
