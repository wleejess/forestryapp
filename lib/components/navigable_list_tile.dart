import "package:flutter/material.dart";

/// A ListTile for use in the (landowner and area) index screens.
///
/// This widget builds a ListTile that enables the caller to specify a route
/// building closure for navigation.
class NavigableListTile extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const double borderWidth = 1;
  static const double borderRadius = 10;

  // Instance variables ////////////////////////////////////////////////////////
  final String _titleText;
  final Widget Function(BuildContext) _routeBuilder;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Builds a ListTile that when tapped navigates to the specified route.
  ///
  /// Will display [titleText] on the ListTile and navigate to the widget built
  /// by [routeBuilder].
  const NavigableListTile(
      {required String titleText,
      required Widget Function(BuildContext) routeBuilder,
      super.key})
      : _titleText = titleText,
        _routeBuilder = routeBuilder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          Text(_titleText, style: Theme.of(context).textTheme.headlineMedium),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: _routeBuilder));
      },
    );
  }
}
