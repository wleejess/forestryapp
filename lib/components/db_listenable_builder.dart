import 'package:flutter/material.dart';
import 'package:forestryapp/models/area_collection.dart';
import 'package:forestryapp/models/landowner_collection.dart';
import 'package:provider/provider.dart';

/// Composite `ListenableBuilder` built to update in response to database
/// changes.
class DBListenableBuilder extends StatelessWidget {
  // Instance Variables ////////////////////////////////////////////////////////
  final Widget Function(BuildContext context, Widget? child) _builder;
  final Widget? _child;

  // https://stackoverflow.com/a/58058091
  const DBListenableBuilder(
      {required Widget Function(BuildContext context, Widget? child) builder,
      Widget? child,
      super.key})
      : _builder = builder,
        _child = child;

  // Use composition instead [Listenable.merge] see
  // https://stackoverflow.com/a/58058091
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Provider.of<LandownerCollection>(context),
      builder: _builderArea,
    );
  }

  Widget _builderArea(BuildContext context, Widget? child) {
    return ListenableBuilder(
      listenable: Provider.of<AreaCollection>(context),
      builder: _builder,
      child: _child,
    );
  }
}
