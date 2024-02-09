import "package:flutter/material.dart";
import "package:forestryapp/util/break_points.dart";

/// Adaptive widget for that takes up differing widths depending on available
/// device width.
class PortraitHandlingSizedBox extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const double _defaultNarrowWidthFactor = 1.0;
  static const double _defaultWideWidthFactor = 0.5;

  // Instance variables ////////////////////////////////////////////////////////
  final double _widthFactorOnNarrowDevices;
  final double _widthFactorOnWideDevices;
  final Widget _child;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Make a widget whose width depends on available device width.
  ///
  /// Wraps [child] in a `FractionallySizedBox` width width factor of
  /// [widthFactorOnNarrowDevices] (defaulting to 1.0) when max device width
  /// falls short of `BreakPoints.widthPhonePortait` and a width factor of
  /// [widthFactorOnNarrowDevices] (defaulting to 0.5) when exceeding said
  /// breakpoint.
  ///
  /// In particular widget is useful when used in conjunction with `Wrap` in
  /// order to avoid horizontal overflows as it will end up wrapping downards
  /// and expand horizontally. When [widthFactorOnNarrowDevices] has a value of
  ///   - 0.50 two of these widgets can be placed side by side
  ///   - 0.25 four of these widgets can be placed side by side
  ///   - etc.
  const PortraitHandlingSizedBox({
    double widthFactorOnNarrowDevices = _defaultNarrowWidthFactor,
    double widthFactorOnWideDevices = _defaultWideWidthFactor,
    required Widget child,
    super.key,
  })  : _child = child,
        _widthFactorOnNarrowDevices = widthFactorOnNarrowDevices,
        _widthFactorOnWideDevices = widthFactorOnWideDevices;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FractionallySizedBox(
          widthFactor: constraints.maxWidth < BreakPoints.widthPhonePortait
              ? _widthFactorOnNarrowDevices
              : _widthFactorOnWideDevices,
          child: Padding(
            padding: const EdgeInsets.all(16.0), 
            child: _child
          ),
        );
      },
    );
  }
}
