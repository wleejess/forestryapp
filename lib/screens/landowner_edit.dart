import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/person_fieldset.dart';

class LandownerEdit extends StatefulWidget {
  static const _title = "Edit Landowner:";
  static const _labelSaveButton = "Save";
  static const _msgSubmit = "Landowner saved!";

  const LandownerEdit({super.key});

  @override
  State<LandownerEdit> createState() => _LandownerEditState();
}

class _LandownerEditState extends State<LandownerEdit> {
  // State Variables ///////////////////////////////////////////////////////////
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
      title: LandownerEdit._title,
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
        child: const Text(LandownerEdit._labelSaveButton),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text(LandownerEdit._msgSubmit, textAlign: TextAlign.center)),
      );
    }
  }
}
