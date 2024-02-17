import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/person_fieldset.dart';
import 'package:forestryapp/database/dao_landowner.dart';
import 'package:forestryapp/database/dto_landowner.dart';
import 'package:forestryapp/enums/us_state.dart';
import 'package:forestryapp/models/landowner.dart';
import 'package:forestryapp/models/landowner_collection.dart';
import 'package:provider/provider.dart';

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

  /// Keep single DTO object for data collection from forms.
  ///
  /// Reuse it to avoid reinitializating each time.
  final _dto = DTOLandowner();

  // Lifecycle Methods /////////////////////////////////////////////////////////

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
              _buildSaveButton(context),
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
      dropdownOnChanged: (usState) => _dto.usState = usState,
    );
  }

  String get _buildTitle {
    Landowner? landowner = widget._landowner;

    return (landowner == null)
        ? LandownerEdit._titleNew
        : "${LandownerEdit._titleEdit} ${landowner.name}";
  }

  Align _buildSaveButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: OutlinedButton(
        onPressed: () => _submitForm(context),
        child: const Text(LandownerEdit._labelSaveButton),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _persist(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            LandownerEdit._msgSubmit,
            textAlign: TextAlign.center,
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  void _persist(BuildContext context) async {
    _collectFormData();

    if (widget._landowner == null) {
      DAOLandowner.saveNewLandowner(_dto); // Save new landowner.
    } else {
      _dto.id = widget._landowner!.id; // non-null because of [if] condition.
      DAOLandowner.updateExistingLandowner(_dto);
    }

    // Update landowners to include newly saved landowner.
    Provider.of<LandownerCollection>(context, listen: false).landowners =
        await DAOLandowner.fetchFromDatabase();
  }

  void _collectFormData() {
    _dto.name = _nameController.text;
    _dto.email = _emailController.text;
    _dto.address = _addressController.text;
    _dto.city = _cityController.text;
    _dto.zip = _zipController.text;
  }
}
