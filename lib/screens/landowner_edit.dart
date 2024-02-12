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
  static const _msgSubmit = "Landowner saved!";

  // Instance variables ////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState(); // Convention is to execute as first line of body.
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();

    super.dispose(); // Convention is to execute this as last line of body.
  }

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
              PersonFieldSet(
                nameController: _nameController,
                emailController: _emailController,
                addressController: _addressController,
                cityController: _cityController,
                zipController: _zipController,
              ),
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
        onPressed: _submitForm,
        child: const Text(_labelSaveButton),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(_msgSubmit, textAlign: TextAlign.center)),
      );
    }
  }
}
