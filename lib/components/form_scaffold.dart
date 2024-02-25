import 'package:flutter/material.dart';
import 'package:forestryapp/models/area.dart';
import 'package:provider/provider.dart';

/// A component to ensure common layout accross the form screens.
class FormScaffold extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _buttonLabelPrevious = "Previous";
  static const _buttonLabelNext = "Next";

  // Instance variables ////////////////////////////////////////////////////////
  final List<Widget> _children;
  final GlobalKey _formKey;

  // Constructor ///////////////////////////////////////////////////////////////
  ///
  const FormScaffold({
    required List<Widget> children,
    required GlobalKey formKey,
    String? currentArea,
    super.key,
  })  : _children = children,
        _formKey = formKey;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    Area currentArea = Provider.of<Area>(context);
    String? areaName = currentArea.name;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Creates a 4x4 grid, but the height matches the content size.
          Container(
            alignment: Alignment.center,
            child: areaName != null
                ? Text(
                    'Current Area: $areaName',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  )
                : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Wrap(
                children: _children,
              ),
            ),
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
