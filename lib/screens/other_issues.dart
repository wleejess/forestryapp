import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/form_scaffold.dart';
import 'package:forestryapp/components/free_text.dart';

class OtherIssues extends StatefulWidget {
  static const _title = "Other Issues";
  static const _otherDescription =
      "Describe any other health related issues you observed.";

  const OtherIssues({super.key});

  @override
  State<OtherIssues> createState() => _OtherIssuesState();
}

class _OtherIssuesState extends State<OtherIssues> {
  // State /////////////////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _otherController;

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    _otherController = TextEditingController();
  }

  @override
  void dispose() {
    _otherController.dispose();

    super.dispose();
  }

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: OtherIssues._title,
      body: FormScaffold(
        formKey: _formKey,
        children: <Widget>[
          _buildDescription(context)
        ],
      )
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  Widget _buildDescription(BuildContext context) {
    return FreeTextBox(
      controller: _otherController, 
      labelText: OtherIssues._title,
      helperText: OtherIssues._otherDescription,
      onChanged: (text) {}
    );
  }
}
