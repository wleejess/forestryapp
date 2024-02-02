import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

class SettingsReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Settings";

  // Instance variables ////////////////////////////////////////////////////////
  // Constructor ///////////////////////////////////////////////////////////////
  const SettingsReview({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return const ForestryScaffold(title: _title, body: Placeholder());
  }
}
