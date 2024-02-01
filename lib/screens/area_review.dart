import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

class AreaReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";

  // Instance variables ////////////////////////////////////////////////////////
  final String _area;

  // Constructor ///////////////////////////////////////////////////////////////
  const AreaReview({required String area, super.key}) : _area = area;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: "$_titlePrefix: $_area",
      body: const Placeholder(),
    );
  }
}
