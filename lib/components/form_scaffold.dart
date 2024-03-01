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
  final Widget _nextPage;
  final Widget? _prevPage;
  

  // Constructor ///////////////////////////////////////////////////////////////
  ///
  const FormScaffold({
    required Widget child,
    required Widget nextPage,
    Widget? prevPage,
    super.key,
  }) : _child = child,
       _nextPage = nextPage,
       _prevPage = prevPage;

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
    if (_prevPage != null) {
      return OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _prevPage),
          );
        },
        child: const Text(_buttonLabelPrevious),
      );
    }
    // If there is no previous link, add a spacer 
    //to keep next on the right side of the screen.
    return Container();
  }

  Widget _buildButtonNext(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _nextPage),
        );
      },
      child: const Text(_buttonLabelNext),
    );
  }
}
