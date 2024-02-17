import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

/// Version of [ForestryScaffold] that just shows an error message.
class ErrorScaffold extends StatelessWidget {
  // Instance Variables ////////////////////////////////////////////////////////
  final String _title;
  final String _bodyText;

  // Constructor ///////////////////////////////////////////////////////////////
  const ErrorScaffold({
    required String title,
    required String bodyText,
    super.key,
  })  : _title = title,
        _bodyText = bodyText;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Center(child: Text(_bodyText)),
    );
  }
}
