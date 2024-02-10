import "package:flutter/material.dart";
import "package:forestryapp/components/contact_info.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/dependency_injection/inherited_preferences.dart";
import "package:forestryapp/screens/settings_edit.dart";

class SettingsReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Settings";
  static const _labelFontSize = "Font Size: ";
  static const _labelEditButton = "Edit";

  // Instance variables ////////////////////////////////////////////////////////
  // Dummy Data for forestry professional until we can implement Shared
  // Preferences.
  final _surveyorName = "John Doe";
  final _surveyorEmail = "j_doe@xyz.com";
  final _surveyorCombinedAddress = "1234 Woodlawn Portland, OR 97211";

  final int _fontSize = 100;

  // Constructor ///////////////////////////////////////////////////////////////
  const SettingsReview({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Column(
        children: [
          ContactInfo(
            name: _surveyorName,
            email: _surveyorEmail,
            combinedAddress: _surveyorCombinedAddress,
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
        Text(_labelFontSize, style: styleLabel),
        Text("$_fontSize %", style: styleFontSizeValue)
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
                sharedPreferences:
                    InheritedSharedPreferences.of(context).sharedPreferences,
              ),
            ),
          );
        },
        child: const Text(_labelEditButton),
      ),
    );
  }
}
