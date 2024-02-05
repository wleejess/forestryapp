import "package:flutter/material.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";

class PersonFieldSet extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _hintName = "Landowner Name";
  static const _hintEmail = "Email";
  static const _hintAddress = "Address";
  static const _hintCity = "City";
  static const _hintState = "State";
  static const _hintZip = "Zip Code";
  static const _paddingBetweenCols = EdgeInsets.all(16);
  static const double _paddingAmountBetweenStateZip = 8;

  // Instance Variables ////////////////////////////////////////////////////////

  // Constructor ///////////////////////////////////////////////////////////////
  const PersonFieldSet({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        PortraitHandlingSizedBox(
          child: Padding(
            padding: _paddingBetweenCols,
            child: Column(
              children: [
                TextFormField(decoration: _makeDecoration(_hintName)),
                TextFormField(decoration: _makeDecoration(_hintEmail))
              ],
            ),
          ),
        ),
        PortraitHandlingSizedBox(
          child: Padding(
            padding: _paddingBetweenCols,
            child: Column(
              children: [
                TextFormField(decoration: _makeDecoration(_hintAddress)),
                TextFormField(decoration: _makeDecoration(_hintCity)),
                Wrap(
                  children: [
                    PortraitHandlingSizedBox(
                        widthFactorOnNarrowDevices: 0.5,
                        widthFactorOnWideDevices: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            0,
                            _paddingAmountBetweenStateZip,
                            0,
                          ),
                          child: TextFormField(
                              decoration: _makeDecoration(_hintState)),
                        )),
                    PortraitHandlingSizedBox(
                      widthFactorOnNarrowDevices: 0.5,
                      widthFactorOnWideDevices: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          _paddingAmountBetweenStateZip,
                          0,
                          0,
                          0,
                        ),
                        child: TextFormField(
                            decoration: _makeDecoration(_hintZip)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  InputDecoration _makeDecoration(String hint) {
    return InputDecoration(hintText: hint);
  }
}
