import "package:flutter/material.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/enums/us_state.dart";

class PersonFieldSet extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
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

  // Instance Variables ////////////////////////////////////////////////////////
  final String _hintName;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _addressController;
  final TextEditingController _cityController;
  final TextEditingController _zipController;

  // Constructor ///////////////////////////////////////////////////////////////
  const PersonFieldSet({
    required hintName,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController addressController,
    required TextEditingController cityController,
    required TextEditingController zipController,
    super.key,
  })  : _hintName = hintName,
        _nameController = nameController,
        _emailController = emailController,
        _addressController = addressController,
        _cityController = cityController,
        _zipController = zipController;

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
    );
  }

  TextFormField _buildEmail() {
    return TextFormField(
      decoration: _makeDecoration(_hintEmail),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
    );
  }

  TextFormField _buildAddress() {
    return TextFormField(
      decoration: _makeDecoration(_hintAddress),
      keyboardType: TextInputType.streetAddress,
      controller: _addressController,
    );
  }

  TextFormField _buildCity() {
    return TextFormField(
      decoration: _makeDecoration(_hintCity),
      controller: _cityController,
    );
  }

  TextFormField _buildZip() {
    return TextFormField(
      decoration: _makeDecoration(_hintZip),
      keyboardType: TextInputType.number,
      controller: _zipController,
    );
  }

  InputDecoration _makeDecoration(String hint) =>
      InputDecoration(hintText: hint);

  // Input: Dropdowns //////////////////////////////////////////////////////////
  DropdownButtonFormField _buildUSState() {
    return DropdownButtonFormField(
      items: <DropdownMenuItem>[
        for (var usState in USState.values)
          DropdownMenuItem(
            value: usState,
            child: Text(usState.label.toUpperCase()),
          )
      ],
      onChanged: (value) => {},
      hint: _hintUSState,
    );
  }
}
