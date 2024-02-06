import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/person_fieldset.dart';

class LandownerEdit extends StatefulWidget {
  const LandownerEdit({super.key});

  @override
  State<LandownerEdit> createState() => _LandownerEditState();
}

class _LandownerEditState extends State<LandownerEdit> {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Edit Landowner:";
  static const _labelSaveButton = "Save";

  // Instance variables ////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const PersonFieldSet(),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildSaveButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: OutlinedButton(
        onPressed: () {},
        child: const Text(_labelSaveButton),
      ),
    );
  }
}
