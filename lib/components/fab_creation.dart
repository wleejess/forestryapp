import "package:flutter/material.dart";

/// FAB to use for creating new model (e.g. landowner or checklist) instance
/// from a list screen.
class FABCreation extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const buttonLabel = "new";

  // Instance variables ////////////////////////////////////////////////////////
  final IconData _icon;
  final void Function() _onPressed;

  // Constructors //////////////////////////////////////////////////////////////
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
