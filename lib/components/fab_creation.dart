import "package:flutter/material.dart";

/// FAB to use for creating new model (e.g. landowner or area) instance
/// from a list screen.
class FABCreation extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const buttonLabel = "new";

  // Instance variables ////////////////////////////////////////////////////////
  final IconData _icon;
  final void Function() _onPressed;

  // Constructors //////////////////////////////////////////////////////////////
  /// Creates a FAB with displaying [icon].
  ///
  /// Executes [onPressed] when tapped. This function should presumably take the
  /// user to an appropriate creation screen.
  const FABCreation(
      {required icon, required void Function() onPressed, super.key})
      : _icon = icon,
        _onPressed = onPressed;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: _onPressed,
      icon: Icon(_icon),
      label: const Text(buttonLabel),
    );
  }
}
