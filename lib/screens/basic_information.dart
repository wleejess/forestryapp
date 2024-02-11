import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";

class BasicInformation extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Basic Information";
  static const _nameHeading = "Area name";
  static const _nameDescription = "If the landowner does not have a name for the"
    "area, make up a descriptive name (meadow, young DF stand, etc.).";
  static const _acresHeading = "Acres";
  static const _acresDescription = "Approximate acres for the stand or area.";
  static const _landownerHeading = "Landowner";
  static const _landownerHint = "John Doe";
  static const _goalsHeading = "Landowner Goals and Objectives";
  static const _goalDescription = "The landowner's goals and objectives for this"
    "specific stand/area.";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen with a form to add name, landowner, and acres to the area.
  const BasicInformation({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: FormScaffold(
        children: <Widget>[
          _buildNameInput(context),
          _buildAcresInput(context),
          _buildGoalsInput(context),
        ],
      )
    );
  }

  // Inputs ////////////////////////////////////////////////////////////////////
  /// Builds a text input field to enter the stand/area name.
  Widget _buildNameInput(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    return PortraitHandlingSizedBox(
      child: FreeTextBox(
        controller: nameController,
        labelText: _nameHeading,
        helperText: _nameDescription,
        onChanged: (text) {}
      ),
    );
  }

  // Builds a numeric input field to enter the acres for the area.
  Widget _buildAcresInput(BuildContext context) {
    final TextEditingController acresController = TextEditingController();
    return PortraitHandlingSizedBox(
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: _acresHeading,
          helperText: _acresDescription,
        ),
        controller: acresController,
      ),
    );
  }

  /// Builds a text input field to enter the landowner's goals for the area.
  Widget _buildGoalsInput(BuildContext context) {
    final TextEditingController goalsController = TextEditingController();

    return FreeTextBox(
      controller: goalsController,
      labelText: _goalsHeading,
      helperText: _goalDescription,
      onChanged: (text) {}
    );
  }
}
