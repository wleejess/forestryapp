import 'package:flutter/material.dart';
import 'package:forestryapp/models/area.dart';
import 'package:provider/provider.dart';

/// A component to ensure common layout accross the form screens.
class FormScaffold extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _buttonLabelPrevious = "Previous";
  static const _buttonLabelNext = "Next";

  // Instance variables ////////////////////////////////////////////////////////
  final Widget _child;

  // Constructor ///////////////////////////////////////////////////////////////
  ///
  const FormScaffold({
    required Widget child,
    super.key,
  }) : _child = child;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    Area currentArea = Provider.of<Area>(context);
    String? areaName = currentArea.name;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: areaName != null
                ? Text(
                    'Currently Editing: $areaName',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  )
                : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _child,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonPrevious(context),
              _buildButtonNext(context),
            ],
          ),
        ],
      ),
    );
  }

  // Buttons ///////////////////////////////////////////////////////////////////
  Widget _buildButtonPrevious(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonLabelPrevious),
    );
  }

  Widget _buildButtonNext(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text(_buttonLabelNext),
    );
  }
}
