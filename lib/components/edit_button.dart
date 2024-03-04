import 'package:flutter/material.dart';
import 'package:forestryapp/models/area.dart';
import 'package:forestryapp/screens/basic_information_form.dart';
import 'package:provider/provider.dart';

class EditButton extends StatelessWidget {
  // Static Variables //////////////////////////////////////////////////////////
  static const _buttonTextEdit = "Edit";

  // Instance Variables ////////////////////////////////////////////////////////
  final Area _area;

  // Constructor ///////////////////////////////////////////////////////////////
  const EditButton(Area area, {super.key}) : _area = area;

  //  //////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _startFormForExistingArea(context),
      child: const Text(_buttonTextEdit),
    );
  }

  void _startFormForExistingArea(BuildContext context) {
    final formArea = Provider.of<Area>(context, listen: false);
    formArea.setFromOther(_area);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BasicInformationForm()),
    );
  }
}
