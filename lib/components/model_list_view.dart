import "package:flutter/material.dart";

/// [ListView] for displaying models to be selected in the side drawer.
///
/// Given a [modelInstances], displays each in its own [ListTile] demarcated
/// with a solid round border.
class ModelListView extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const double tileFontSize = 36.0;
  static const double borderWidth = 1;
  static const double borderRadius = 10;

  // Instance variables ////////////////////////////////////////////////////////
  final List<String> modelInstances;

  // Constructor ///////////////////////////////////////////////////////////////
  const ModelListView({required this.modelInstances, super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildLandownerBuilder,
      itemCount: modelInstances.length,
    );
  }

  ListTile _buildLandownerBuilder(BuildContext context, int i) {
    return ListTile(
      title: Text(modelInstances[i],
          style: const TextStyle(fontSize: tileFontSize)),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
