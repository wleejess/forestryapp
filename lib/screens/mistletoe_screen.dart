import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/radio_options.dart";

class MistletoeScreen extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Mistletoe Infections";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to enter information on mistletoe infections.
  const MistletoeScreen({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Column(
        children: <Widget>[
        ],
      ),
    );
  }

}
