import "package:flutter/material.dart";
import "package:forestryapp/enums/us_state.dart";
import "package:forestryapp/models/landowner.dart";
import 'package:provider/provider.dart';
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/models/basic_information.dart";

class BasicInformationForm extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Basic Information";
  static const _nameHeading = "Area name";
  static const _nameDescription = "If the landowner does not have a name for the "
    "area, make up a descriptive name (meadow, young DF stand, etc.).";
  static const _acresHeading = "Acres";
  static const _acresDescription = "Approximate acres for the stand or area.";
  static const _landownerHeading = "Landowner";
  static const _goalsHeading = "Landowner Goals and Objectives";
  static const _goalDescription = "The landowner's goals and objectives for this "
    "specific stand/area.";

  final _formKey = GlobalKey<FormState>();

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen with a form to add name, landowner, and acres to the area.
  BasicInformationForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: BasicInformationForm._title,
      body: FormScaffold(
        formKey: _formKey,
        children: <Widget>[
          _buildNameInput(context),
          _buildAcresInput(context),
          _buildLandownerInput(context),
          _buildGoalsInput(context),
        ],
      )
    );
  }

  /// Builds a text input field to enter the stand/area name.
  Widget _buildNameInput(BuildContext context) {
    final basicInfoData = Provider.of<BasicInformation>(context);

    return PortraitHandlingSizedBox(
      child: FreeTextBox(
        labelText: BasicInformationForm._nameHeading,
        helperText: BasicInformationForm._nameDescription,
        initialValue: basicInfoData.name,
        onChanged: (text) {
          basicInfoData.name = text;
        }
      ),
    );
  }

  /// Builds a numeric input field to enter the acres for the area.
  Widget _buildAcresInput(BuildContext context) {
    final basicInfoData = Provider.of<BasicInformation>(context);

    return PortraitHandlingSizedBox(
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: BasicInformationForm._acresHeading,
          helperText: BasicInformationForm._acresDescription,
        ),
        initialValue: () {
          if (basicInfoData.acres == null) {
            return '';
          } 
          return basicInfoData.acres.toString();
        }(),
        onChanged: (text) {
          if (text.isNotEmpty) {
            basicInfoData.acres = double.tryParse(text);
          } else {
            basicInfoData.acres = null;
          }
        },
      ),
    );
  }

  /// Builds a Search bar to select a Landowner for the area.
  Widget _buildLandownerInput(BuildContext context) {
    final basicInfoData = Provider.of<BasicInformation>(context);

    List<Landowner> landownerOptions = <Landowner>[
      Landowner(id: 0, name: "Amy Adams", email: "a@gmail.com", address: "1234 Alpha Street", city: "Acton", state: USState.alabama, zip: "1"),
      Landowner(id: 1, name: "Bob Bancroft", email: "b@gmail.com", address: "1234 Beta Street", city: "Burne", state: USState.arizona, zip: "2"),
      Landowner(id: 2, name: "Chet Chapman", email: "c@gmail.com", address: "1234 Gamma Street", city: "Chico", state: USState.california, zip: "3"),
      Landowner(id: 3, name: "Donna Dawson", email: "d@gmail.com", address: "1234 Delta Street", city: "Davis", state: USState.delaware, zip: "4"),
      Landowner(id: 4, name: "Edgar Edmonds", email: "e@gmail.com", address: "1234 Epsilon Street", city: "Empire", state: USState.oregon, zip: "5"),
    ];

    Landowner? getInitialValue() {
      if (basicInfoData.landowner != null) {
        return landownerOptions.firstWhere((element) => basicInfoData.landowner!.id == element.id);
      }
      return null;
    }

    return DropdownMenu(
      enableFilter: true,
      requestFocusOnTap: true,
      expandedInsets: EdgeInsets.zero,
      leadingIcon: const Icon(Icons.search),
      label: const Text(_landownerHeading),
      initialSelection: getInitialValue(),
      dropdownMenuEntries: landownerOptions.map<DropdownMenuEntry<Landowner>>(
        (Landowner landowner) {
          return DropdownMenuEntry(
            value: landowner, 
            label: landowner.name
          );
        },
      ).toList(),
      onSelected: (Landowner? value) {
        basicInfoData.landowner = value;
      },
    );
  }

  /// Builds a text input field to enter the landowner's goals for the area.
  Widget _buildGoalsInput(BuildContext context) {
    final basicInfoData = Provider.of<BasicInformation>(context);

    return FreeTextBox(
      labelText: BasicInformationForm._goalsHeading,
      helperText: BasicInformationForm._goalDescription,
      initialValue: basicInfoData.goals,
      onChanged: (text) {
        basicInfoData.goals = text;
      }
    );
  }
}
