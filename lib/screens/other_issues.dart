import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/util/break_points.dart';

class OtherIssues extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  static const _title = "Other Issues";
  static const _otherDescription =
      "Describe any other health related issues you observed.";
  static const _buttonLabelPrevious = "Previous";
  static const _buttonLabelNext = "Next";

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildDescription(context),
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

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a TextField with a label, helper text, and an outline.
  Widget _buildTextInput(BuildContext context, label, helper) {
    return TextField(
      controller: _textEditingController,
      maxLines:
          null, // Setting this to null allows the TextField to expand as needed
      keyboardType: TextInputType.multiline, // Specify the keyboard type
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextInput(context, _title, _otherDescription),
        const SizedBox(height: 16.0),
        const Text(
          _otherDescription,
          style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
        ),
      ],
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
