import "package:flutter/material.dart";
import "package:forestryapp/util/relative_size.dart";

/// Variant on `SizedBox` that can specify distance in terms of percentages of
/// device dimensions.
class RelativeSizedBox extends StatelessWidget {
  // Instance Variables ////////////////////////////////////////////////////////
  final double _percentage;
  final Widget _child;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a sized box with dimensions given as percentage of screen size.
  ///
  /// If [percentageHeight] is omitted, takes the entire screen height.
  const RelativeSizedBox({
    double percentageHeight = 1,
    required child,
    super.key,
  })  : _percentage = percentageHeight,
        _child = child;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: RelativeSize.computeHeight(context, _percentage),
      child: _child,
    );
  }
}
