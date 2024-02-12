import "package:flutter/material.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/enums/us_state.dart";

class PersonFieldSet extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _hintNameEvaluator = "Evaluator Name";
  static const _hintNameLandowner = "Landowner Name";
  static const _hintEmail = "Email";
  static const _hintAddress = "Address";
  static const _hintCity = "City";
  static const _hintUSState = Text("State"); // Dropdown hint takes a widget.
  static const _hintZip = "Zip Code";
  static const _paddingBetweenCols = EdgeInsets.all(16);
  static const double _paddingAmountBetweenUSStateZip = 8;

  /// Pad only the right since state dropdown is on the left.
  static const _paddingUSState =
      EdgeInsets.fromLTRB(0, 0, _paddingAmountBetweenUSStateZip, 0);

  /// Pad only the left since zip code field is on the right.
  static const _paddingZip =
      EdgeInsets.fromLTRB(_paddingAmountBetweenUSStateZip, 0, 0, 0);

  /// How much of parent width and state take up.
  ///
  /// They should be equal and take a total of 1.0 of their parent as they share
  /// a line.
  static const _widthFactorUSStateZip = 0.5;

  static const _warnEmptyName = 'Name is required';
  static const _warnEmptyEmail = 'Email is required';
  static const _warnInvalidEmail = 'Supply a valid email address';
  static const _warnEmptyAddress = 'Address is required';
  static const _warnEmptyCity = 'City is required';
  static const _warnEmptyUSState = 'State is required';
  static const _warnEmptyZip = 'Zip Code is required';
  static const _warnZipDigitsOnly = "Use only digits and hyphens";

  /// Simple email validation pattern.
  ///
  /// *ATTRIBUTION*
  /// Source: Stack Overflow
  /// URL: https://stackoverflow.com/a/50663835
  /// Question Author: Eric Lavoie
  /// Question Author Profile: https://stackoverflow.com/users/1478085/eric-lavoie
  /// Answer Author: Airon Tark
  /// Answer Author Profile: https://stackoverflow.com/users/1003008/airon-tark
  static final _emailValidationRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// Basic validation for zip code.
  /// Does not distinguish between basic and extended. Only allows for digits
  /// and hyphens and does not check length.
  static final _zipValidationRegExp = RegExp(r'^[0-9\-]+$');

  // Instance Variables ////////////////////////////////////////////////////////
  final String _hintName;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _addressController;
  final TextEditingController _cityController;
  final TextEditingController _zipController;
  final USState? _initialUSState;
  final void Function(dynamic)? _dropdownOnChanged;

  // Constructor ///////////////////////////////////////////////////////////////
  const PersonFieldSet({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController addressController,
    required TextEditingController cityController,
    required TextEditingController zipController,
    USState? initialUSState,
    Function(dynamic)? dropdownOnChanged,
    bool editingEvaluator = false,
    super.key,
  })  : _nameController = nameController,
        _emailController = emailController,
        _addressController = addressController,
        _cityController = cityController,
        _zipController = zipController,
        _initialUSState = initialUSState,
        _dropdownOnChanged = dropdownOnChanged,
        _hintName = editingEvaluator ? _hintNameEvaluator : _hintNameLandowner;

  // Layout ////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        _buildNameAndEmailFields(), // Will be on left or on top.
        _buildAddressRelatedFields() // Will be on right or below.
      ],
    );
  }

  PortraitHandlingSizedBox _buildNameAndEmailFields() {
    return PortraitHandlingSizedBox(
      child: Padding(
        padding: _paddingBetweenCols,
        child: Column(children: [_buildName(), _buildEmail()]),
      ),
    );
  }

  PortraitHandlingSizedBox _buildAddressRelatedFields() {
    return PortraitHandlingSizedBox(
      child: Padding(
        padding: _paddingBetweenCols,
        child: Column(
          children: [
            _buildAddress(),
            _buildCity(),
            Wrap(children: [
              _constrainUSStateZipRow(_paddingUSState, _buildUSState()),
              _constrainUSStateZipRow(_paddingZip, _buildZip()),
            ])
          ],
        ),
      ),
    );
  }

  Widget _constrainUSStateZipRow(EdgeInsets padding, Widget child) {
    return FractionallySizedBox(
      widthFactor: _widthFactorUSStateZip,
      child: Padding(padding: padding, child: child),
    );
  }

  // Input: Text Fields ////////////////////////////////////////////////////////
  TextFormField _buildName() {
    return TextFormField(
      decoration: _makeDecoration(_hintName),
      keyboardType: TextInputType.name,
      controller: _nameController,
      // Only check if empty because no other domain specific requirements.
      validator: _validateToCheckIfEmpty(_warnEmptyName),
    );
  }

  TextFormField _buildEmail() {
    return TextFormField(
      decoration: _makeDecoration(_hintEmail),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: _validateEmail,
    );
  }

  TextFormField _buildAddress() {
    return TextFormField(
      decoration: _makeDecoration(_hintAddress),
      keyboardType: TextInputType.streetAddress,
      controller: _addressController,
      // Only check if empty because no other domain specific requirements.
      validator: _validateToCheckIfEmpty(_warnEmptyAddress),
    );
  }

  TextFormField _buildCity() {
    return TextFormField(
      decoration: _makeDecoration(_hintCity),
      controller: _cityController,
      // Only check if empty because no other domain specific requirements.
      validator: _validateToCheckIfEmpty(_warnEmptyCity),
    );
  }

  TextFormField _buildZip() {
    return TextFormField(
      decoration: _makeDecoration(_hintZip),
      keyboardType: TextInputType.number,
      controller: _zipController,
      validator: _validateZip,
    );
  }

  InputDecoration _makeDecoration(String hint) =>
      InputDecoration(hintText: hint);

  // Input: Dropdowns //////////////////////////////////////////////////////////
  DropdownButtonFormField _buildUSState() {
    return DropdownButtonFormField(
      items: _createDropdownItems,
      value: _initialUSState,
      hint: _hintUSState,
      onChanged: _dropdownOnChanged,
      validator: _validateUSState,
    );
  }

  List<DropdownMenuItem<dynamic>> get _createDropdownItems {
    return <DropdownMenuItem>[
      for (var usState in USState.values)
        DropdownMenuItem(
          value: usState,
          child: Text(usState.label.toUpperCase()),
        )
    ];
  }

  // Validators ////////////////////////////////////////////////////////////////
  /// Higher order function that creates an anonymous validator for a field.
  ///
  /// The returned validator only checks to see if the field is empty. If it is,
  /// then it returns the provided message [validationMessageWhenFieldIsEmpty].
  String? Function(String? value) _validateToCheckIfEmpty(
      String validationMessageWhenFieldIsEmpty) {
    return (String? validationCandidate) {
      if (validationCandidate == null || validationCandidate.isEmpty) {
        return validationMessageWhenFieldIsEmpty;
      }
      return null;
    };
  }

  /// Checks if empty and then if valid email (via Regular Expression).
  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return _warnEmptyEmail;
    }

    if (!_emailValidationRegExp.hasMatch(email)) {
      return _warnInvalidEmail;
    }

    return null;
  }

  String? _validateZip(String? zip) {
    if (zip == null || zip.isEmpty) {
      return _warnEmptyZip;
    }

    if (!zip.contains(_zipValidationRegExp)) {
      return _warnZipDigitsOnly;
    }

    return null;
  }

  String? _validateUSState(dynamic usState) {
    if (usState == null ||
        usState is! Enum ||
        !USState.values.contains(usState)) {
      return _warnEmptyUSState;
    }

    return null;
  }
}
