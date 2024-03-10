import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/person_fieldset.dart';
import 'package:forestryapp/database/dao_landowner.dart';
import 'package:forestryapp/database/dto_landowner.dart';
import 'package:forestryapp/enums/us_state.dart';
import 'package:forestryapp/models/area_collection.dart';
import 'package:forestryapp/models/landowner.dart';
import 'package:forestryapp/models/landowner_collection.dart';
import 'package:provider/provider.dart';

/// Screen for either inserting a new landowner into the database or editing an
/// existing one.
class LandownerEdit extends StatefulWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _titleEdit = "Edit Landowner:";
  static const _titleNew = "New Landowner";
  static const _labelSaveButton = "Save";
  static const _msgSubmit = "Landowner saved!";

  // Instance Variables ////////////////////////////////////////////////////////
  final Landowner? _landowner;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Create a screen to show a form to enter landowner information.
  ///
  /// Assumes that if [landownerToEdit] is [null] then the screen is being used
  /// for creating a new landowner. Otherwise the screen is being used to update
  /// an existing landowner.
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
      // Updating an existing landowner.
      _nameController.text = landowner.name;
      _emailController.text = landowner.email;
      _addressController.text = landowner.address;
      _cityController.text = landowner.city;
      _zipController.text = landowner.zip;
      initialUSState = landowner.state;

      // ASSUMPTION: Since [landowner] is non-null that means it must originate
      // from a valid database record. From that, it follows that since the
      // schema enforces non-null US State it is safe to assume that
      // [landowner.state] is likewise non-null.  Make sure [_dto.usState
      // initialized]. This is not an issue when
      _dto.usState = landowner.state!;
    } else {
      // Creating a new landowner.
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
        onPressed: () async => await _submitForm(context),
        child: const Text(LandownerEdit._labelSaveButton),
      ),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      await _persist(context);
      if (!context.mounted) return;
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

  Future<void> _persist(BuildContext context) async {
    _collectFormData();

    if (widget._landowner == null) {
      await DAOLandowner.saveNewLandowner(_dto);
    } else {
      _dto.id = widget._landowner!.id; // non-null because of [if] condition.
      await DAOLandowner.updateExistingLandowner(_dto);
    }
    if (!context.mounted) return;

    // Update landowners to include newly saved landowner.
    await Provider.of<LandownerCollection>(context, listen: false).refetch();
    if (!context.mounted) return;
    await Provider.of<AreaCollection>(context, listen: false).refetch();
  }

  /// Transfer form field data into the DTO to prepare it for sendoff to DAO.
  void _collectFormData() {
    // ASSUMPTION: Note that US State is not collected here as it is assumed to
    // be automatically updated by the callback passed to
    // [PersonFieldSet.dropdownOnChanged].
    _dto.name = _nameController.text;
    _dto.email = _emailController.text;
    _dto.address = _addressController.text;
    _dto.city = _cityController.text;
    _dto.zip = _zipController.text;
  }
}
