import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

class Home extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Welcome to the Forest Wellness Checkup App";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a the home page / introduction screen.
  const Home({
    super.key,
  });

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return const ForestryScaffold(
      title: _title,
      body: Center(
          child: Text("Hello."),
      )
    );
  }
}
