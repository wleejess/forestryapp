import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/person_fieldset.dart';
import 'package:forestryapp/enums/settings_key.dart';
import 'package:forestryapp/enums/us_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsEdit extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Edit Settings";
  static const _labelSaveButton = "Save";
  static const double _minFontSize = 0;
  static const double _maxFontSize = 400;
  static const double _defaultFontSize = 100;
  static const _msgSubmit = "Settings updated!";

  // Instance Variables ////////////////////////////////////////////////////////
  final SharedPreferences _sharedPreferences;

  // Constructor ///////////////////////////////////////////////////////////////
  const SettingsEdit({required SharedPreferences sharedPreferences, super.key})
      : _sharedPreferences = sharedPreferences;

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

  double get _fontSize {
    return widget._sharedPreferences.getDouble(SettingsKey.fontSize) ??
        SettingsEdit._defaultFontSize;
  }

  set _fontSize(double newFontSize) {
    widget._sharedPreferences.setDouble(SettingsKey.fontSize, newFontSize);
  }

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState(); // Convention is to execute as first line of body.
    _nameController =
        TextEditingController(text: _readSetting(SettingsKey.evaluatorName));
    _emailController =
        TextEditingController(text: _readSetting(SettingsKey.evaluatorEmail));
    _addressController =
        TextEditingController(text: _readSetting(SettingsKey.evaluatorAddress));
    _cityController =
        TextEditingController(text: _readSetting(SettingsKey.evaluatorCity));
    _zipController =
        TextEditingController(text: _readSetting(SettingsKey.evaluatorZip));
  }

  /// Retrieve value (or fallback) stored in SharedSettings with provided key.
  ///
  /// Assumes [settingsKey] is a valid key in `SharedSettings`. Assumes value
  /// stored with key [settingsKey] is indeed a string. Will return [fallback]
  /// if [settingsKey] is not found.
  String _readSetting(String settingsKey, {String fallback = ""}) =>
      widget._sharedPreferences.getString(settingsKey) ?? fallback;

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
                initialUSState: _readInitialUSState(),
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
            "Font Size: ${_formatFontSize()}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Expanded(child: _buildFontSizeSlider()),
        ],
      ),
    );
  }

  String _formatFontSize() =>
      "${_fontSize.toStringAsFixed(0).padLeft(3, ' ')} %";

  Slider _buildFontSizeSlider() {
    return Slider(
      value: _fontSize,
      min: SettingsEdit._minFontSize,
      max: SettingsEdit._maxFontSize,
      onChanged: (newFontSize) => {
        setState(
          () {
            // Immediately saves font size to shared preferences via setter as
            // we can skip middle man state variable and directly use Shared
            // Preferences for state. Save button not needed since slider cannot
            // be validated.
            _fontSize = newFontSize;
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
    }
  }

  void storeContactInfoSettings() {
    widget._sharedPreferences
        .setString(SettingsKey.evaluatorName, _nameController.text);
    widget._sharedPreferences
        .setString(SettingsKey.evaluatorEmail, _emailController.text);
    widget._sharedPreferences
        .setString(SettingsKey.evaluatorAddress, _addressController.text);
    widget._sharedPreferences
        .setString(SettingsKey.evaluatorCity, _cityController.text);
    widget._sharedPreferences
        .setString(SettingsKey.evaluatorZip, _zipController.text);
  }

  USState? _readInitialUSState() {
    final String storedUSStateString =
        _readSetting(SettingsKey.evaluatorUSState);
    for (var usState in USState.values) {
      if (usState.label == storedUSStateString) return usState;
    }
    return null;
  }

  /// Immediately stores US State from dropdown to `SavedPreferences`.
  void _storeUSState(dynamic usState) {
    if (usState is USState) {
      // Store directly to `SharedPreferences` using it as state to avoid middle
      // man state variable.
      widget._sharedPreferences
          .setString(SettingsKey.evaluatorUSState, usState.label);
      return;
    }

    throw Exception(
      "Dropdown US State not of type `USState` despite validation.",
    );
  }
}
