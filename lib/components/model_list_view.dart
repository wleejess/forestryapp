import "package:flutter/material.dart";

/// [ListView] for displaying models to be selected in the side drawer.
class ModelListView extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const double borderWidth = 1;
  static const double borderRadius = 10;

  // Instance variables ////////////////////////////////////////////////////////
  final List<String> _modelInstances;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Given a [_modelInstances], displays each in its own [ListTile] demarcated
  /// with a solid round border.
  const ModelListView({required List<String> modelInstances, super.key})
      : _modelInstances = modelInstances;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildLandownerBuilder,
      itemCount: _modelInstances.length,
    );
  }

  ListTile _buildLandownerBuilder(BuildContext context, int i) {
    return ListTile(
      title: Text(_modelInstances[i],
          style: Theme.of(context).textTheme.headlineMedium),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
