import "package:flutter/material.dart";
import "package:forestryapp/components/contact_info.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/models/settings.dart";

import "package:forestryapp/screens/settings_edit.dart";

/// Screen for user (evaluator) to input/update their settings.
class SettingsReview extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Settings";
  static const _labelFontSize = "Font Size: ";
  static const _labelEditButton = "Edit";
  static const _fallbackEvaluatormName = "Evaluator Name";

  // Instance variables ////////////////////////////////////////////////////////
  // Dummy Data for forestry professional until we can implement Shared
  // Preferences.
  final Settings _settings;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Create screen for user (evaluator) to input/update their settings.
  ///
  /// [settings] is assumed to be initialized and used for storing/retrieving
  /// user settings.
  const SettingsReview({required Settings settings, super.key})
      : _settings = settings;

  @override
  State<SettingsReview> createState() => _SettingsReviewState();
}

class _SettingsReviewState extends State<SettingsReview> {
  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: SettingsReview._title,
      body: Column(
        children: [
          ContactInfo(
            name: (widget._settings.evaluatorName.isEmpty)
                ? SettingsReview._fallbackEvaluatormName
                : widget._settings.evaluatorName,
            email: widget._settings.evaluatorEmail,
            combinedAddress: widget._settings.combinedAddress,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: _buildFontSizeRow(context),
          ),
          Expanded(child: Container()),
          _buildEditButton(context),
        ],
      ),
    );
  }

  Row _buildFontSizeRow(BuildContext context) {
    final TextStyle? styleFontSizeValue =
        Theme.of(context).textTheme.headlineSmall;
    final TextStyle styleLabel =
        styleFontSizeValue!.copyWith(fontWeight: FontWeight.bold);

    return Row(
      children: [
        Text(SettingsReview._labelFontSize, style: styleLabel),
        Text("${widget._settings.fontSize.toStringAsFixed(0)} %",
            style: styleFontSizeValue)
      ],
    );
  }

  Align _buildEditButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsEdit(
                settings: widget._settings,
              ),
            ),
            // Force rebuild or else this screen won't show the updated changes
            // that the evaluator input if they navigate back to this screen
            // from the Settings Edit page.
          ).then((_) => setState(() {}));
        },
        child: const Text(SettingsReview._labelEditButton),
      ),
    );
  }
}
