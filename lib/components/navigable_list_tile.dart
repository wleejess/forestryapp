import "package:flutter/material.dart";

/// A ListTile for use in the (landowner and area) index screens.
///
/// This class enables a consistent theming between [ListTiles] the two screens.
class NavigableListTile extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const double borderWidth = 1;
  static const double borderRadius = 10;

  // Instance variables ////////////////////////////////////////////////////////
  final String _titleText;
  final void Function()? _onTap;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Builds a ListTile that when tapped navigates to the specified route.
  ///
  /// Will display [titleText] on the ListTile and navigate to the widget built
  /// by [routeBuilder].
  const NavigableListTile(
      {required String titleText, required void Function()? onTap, super.key})
      : _titleText = titleText,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          Text(_titleText, style: Theme.of(context).textTheme.headlineMedium),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onTap: _onTap,
    );
  }
}
