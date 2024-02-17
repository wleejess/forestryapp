import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/person_fieldset.dart';
import 'package:forestryapp/enums/us_state.dart';
import 'package:forestryapp/models/landowner.dart';

class LandownerEdit extends StatefulWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _titleEdit = "Edit Landowner:";
  static const _titleNew = "New Landowner";
  static const _labelSaveButton = "Save";
  static const _msgSubmit = "Landowner saved!";

  // Instance Variables ////////////////////////////////////////////////////////

  final Landowner? _landowner;

  // Constructor ///////////////////////////////////////////////////////////////
  const LandownerEdit({Landowner? landownerToEdit, super.key})
      : _landowner = landownerToEdit;

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
      title: _buildTitle,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildFields(context),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Build input fields for contact info.
  ///
  /// When editing an existing landowner, populate fields with their
  /// data. Otherwise just leave the fields blank.
  Widget _buildFields(BuildContext context) {
    final landowner = widget._landowner;
    late final USState? initialUSState;


    if (landowner != null) {
      _nameController.text = landowner.name;
      _emailController.text = landowner.email;
      _addressController.text = landowner.address;
      _cityController.text = landowner.city;
      _zipController.text = landowner.zip;
      initialUSState = landowner.state;
    } else {
      initialUSState = null;
    }

    return PersonFieldSet(
      nameController: _nameController,
      emailController: _emailController,
      addressController: _addressController,
      cityController: _cityController,
      zipController: _zipController,
      initialUSState: initialUSState,
    );
  }

  String get _buildTitle {
    Landowner? landowner = widget._landowner;

    return (landowner == null)
        ? LandownerEdit._titleNew
        : "${LandownerEdit._titleEdit}${landowner.name}";
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
          content: Text(
            LandownerEdit._msgSubmit,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
