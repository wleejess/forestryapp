import "package:flutter/material.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/enums/us_state.dart";

class PersonFieldSet extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _hintName = "Landowner Name";
  static const _hintEmail = "Email";
  static const _hintAddress = "Address";
  static const _hintCity = "City";
  static const _hintState = Text("State"); // Dropdown hint takes a widget.
  static const _hintZip = "Zip Code";
  static const _paddingBetweenCols = EdgeInsets.all(16);
  static const double _paddingAmountBetweenStateZip = 8;

  /// Pad only the right since state dropdown is on the left.
  static const _paddingState =
      EdgeInsets.fromLTRB(0, 0, _paddingAmountBetweenStateZip, 0);

  /// Pad only the left since zip code field is on the right.
  static const _paddingZip =
      EdgeInsets.fromLTRB(_paddingAmountBetweenStateZip, 0, 0, 0);

  /// How much of parent width and state take up.
  ///
  /// They should be equal and take a total of 1.0 of their parent as they share
  /// a line.
  static const _widthFactorStateZip = 0.5;

  // Instance Variables ////////////////////////////////////////////////////////
  // Constructor ///////////////////////////////////////////////////////////////
  const PersonFieldSet({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        _buildNameAndEmailFields(),
        _buildAddressRelatedFields()
      ],
    );
  }

  // Name and Email Fields /////////////////////////////////////////////////////
  PortraitHandlingSizedBox _buildNameAndEmailFields() {
    return PortraitHandlingSizedBox(
      child: Padding(
        padding: _paddingBetweenCols,
        child: Column(
          children: [
            TextFormField(decoration: _makeDecoration(_hintName)),
            TextFormField(decoration: _makeDecoration(_hintEmail))
          ],
        ),
      ),
    );
  }

  // Address Related Fields ////////////////////////////////////////////////////
  PortraitHandlingSizedBox _buildAddressRelatedFields() {
    return PortraitHandlingSizedBox(
      child: Padding(
        padding: _paddingBetweenCols,
        child: Column(
          children: [
            TextFormField(decoration: _makeDecoration(_hintAddress)),
            TextFormField(decoration: _makeDecoration(_hintCity)),
            Wrap(children: [_buildState(), _buildZip()])
          ],
        ),
      ),
    );
  }

  Widget _buildState() {
    return FractionallySizedBox(
      widthFactor: _widthFactorStateZip,
      child: Padding(
        padding: _paddingState,
        child: DropdownButtonFormField(
          items: <DropdownMenuItem>[
            for (var state in USState.values)
              DropdownMenuItem(
                  value: state, child: Text(state.label.toUpperCase()))
          ],
          onChanged: (value) => {},
          hint: _hintState,
        ),
      ),
    );
  }

  Widget _buildZip() {
    return FractionallySizedBox(
      widthFactor: _widthFactorStateZip,
      child: Padding(
        padding: _paddingZip,
        child: TextFormField(decoration: _makeDecoration(_hintZip)),
      ),
    );
  }

  // Form Field Specific ///////////////////////////////////////////////////////
  InputDecoration _makeDecoration(String hint) {
    return InputDecoration(hintText: hint);
  }
}
