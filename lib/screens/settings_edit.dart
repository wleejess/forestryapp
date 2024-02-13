import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/person_fieldset.dart';
import 'package:forestryapp/enums/us_state.dart';
import 'package:forestryapp/models/settings.dart';

class SettingsEdit extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Edit Settings";
  static const _labelSaveButton = "Save";
  static const _labelFontSize = "Font Size: ";
  static const _msgSubmit = "Settings updated!";
  static const _warningValidationFailType =
      "Dropdown US State not of type `USState?` despite validation.";

  // Instance Variables ////////////////////////////////////////////////////////
  final Settings _settings;

  // Constructor ///////////////////////////////////////////////////////////////
  const SettingsEdit({required Settings settings, super.key})
      : _settings = settings;

  @override
  State<SettingsEdit> createState() => _SettingsEditState();
}

class _SettingsEditState extends State<SettingsEdit> {
  // State /////////////////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _zipController;

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState(); // Convention is to execute as first line of body.

    _nameController =
        TextEditingController(text: widget._settings.evaluatorName);
    _emailController =
        TextEditingController(text: widget._settings.evaluatorEmail);
    _addressController =
        TextEditingController(text: widget._settings.evaluatorAddress);
    _cityController =
        TextEditingController(text: widget._settings.evaluatorCity);
    _zipController = TextEditingController(text: widget._settings.evaluatorZip);
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
      title: SettingsEdit._title,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PersonFieldSet(
                nameController: _nameController,
                emailController: _emailController,
                addressController: _addressController,
                cityController: _cityController,
                zipController: _zipController,
                initialUSState: widget._settings.evaluatorUSState,
                dropdownOnChanged: _storeUSState,
                editingEvaluator: true,
              ),
              _buildFontSizeSection(context),
              _buildSaveButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFontSizeSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: Row(
        children: [
          Text(
            "${SettingsEdit._labelFontSize}${_formatFontSize()}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Expanded(child: _buildFontSizeSlider()),
        ],
      ),
    );
  }

  String _formatFontSize() =>
      "${widget._settings.fontSize.toStringAsFixed(0).padLeft(3, ' ')} %";

  Slider _buildFontSizeSlider() {
    return Slider(
      value: widget._settings.fontSize,
      min: Settings.minFontSize,
      max: Settings.maxFontSize,
      onChanged: (newFontSize) => {
        setState(
          () {
            // Immediately saves font size to shared preferences via setter as
            // we can skip middle man state variable and directly use Shared
            // Preferences for state. Save button not needed since slider cannot
            // be validated.
            widget._settings.fontSize = newFontSize;
          },
        )
      },
      divisions: 8,
      label: _formatFontSize(),
    );
  }

  Align _buildSaveButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: OutlinedButton(
        onPressed: _submitForm,
        child: const Text(SettingsEdit._labelSaveButton),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      storeContactInfoSettings();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(SettingsEdit._msgSubmit, textAlign: TextAlign.center),
        ),
      );
      Navigator.pop(context);
    }
  }

  void storeContactInfoSettings() {
    widget._settings.evaluatorName = _nameController.text;
    widget._settings.evaluatorEmail = _emailController.text;
    widget._settings.evaluatorAddress = _addressController.text;
    widget._settings.evaluatorCity = _cityController.text;
    widget._settings.evaluatorZip = _zipController.text;
  }

  /// Immediately stores US State from dropdown to `SavedPreferences`.
  _storeUSState(dynamic usState) {
    if (usState is! USState?) {
      // Sanity check: `usState` should have type `USState` otherwise user
      // somehow managed to force the dropdown to take some other unexpected
      // type (which should not be possible). This should not be caught but
      // instead addressed by the programmer if thrown. See Exceptions vs Errors
      // https://stackoverflow.com/a/58361954 for the difference between the two
      // Dart types.
      throw AssertionError(SettingsEdit._warningValidationFailType);
    }

    widget._settings.evaluatorUSState = usState;
  }
}
