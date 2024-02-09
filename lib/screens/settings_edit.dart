import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';
import 'package:forestryapp/components/person_fieldset.dart';

class SettingsEdit extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Edit Settings";
  static const _labelSaveButton = "Save";
  static const double _minFontSize = 0;
  static const double _maxFontSize = 400;
  static const _msgSubmit = "Settings updated!";

  // Constructor ///////////////////////////////////////////////////////////////
  const SettingsEdit({super.key});

  @override
  State<SettingsEdit> createState() => _SettingsEditState();
}

class _SettingsEditState extends State<SettingsEdit> {
  // State variables ///////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  double _fontSize = 100;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

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
        setState(() {
          _fontSize = newFontSize;
        })
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(SettingsEdit._msgSubmit, textAlign: TextAlign.center),
        ),
      );
    }
  }
}
