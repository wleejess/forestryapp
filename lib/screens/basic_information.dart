import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";
import "package:forestryapp/models/basic_info_data.dart";

class BasicInformation extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Basic Information";
  static const _nameHeading = "Area name";
  static const _nameDescription = "If the landowner does not have a name for the "
    "area, make up a descriptive name (meadow, young DF stand, etc.).";
  static const _acresHeading = "Acres";
  static const _acresDescription = "Approximate acres for the stand or area.";
  static const _landownerHeading = "Landowner";
  static const _landownerHint = "John Doe";
  static const _goalsHeading = "Landowner Goals and Objectives";
  static const _goalDescription = "The landowner's goals and objectives for this "
    "specific stand/area.";

  /// Dummy data to be replaced by model later.
  static const _landowners = [
    "Amy Adams",
    "Bob Bancroft",
    "Chet Chapman",
    "Donna Dawson",
    "Edgar Edmonds",
  ];

  final _formKey = GlobalKey<FormState>();

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen with a form to add name, landowner, and acres to the area.
  BasicInformation({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: BasicInformation._title,
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
    final basicInfoData = Provider.of<BasicInfoDataModel>(context);

    return PortraitHandlingSizedBox(
      child: FreeTextBox(
        labelText: BasicInformation._nameHeading,
        helperText: BasicInformation._nameDescription,
        initialValue: basicInfoData.name,
        onChanged: (text) {
          basicInfoData.name = text;
        }
      ),
    );
  }

  /// Builds a numeric input field to enter the acres for the area.
  Widget _buildAcresInput(BuildContext context) {
    final basicInfoData = Provider.of<BasicInfoDataModel>(context);

    return PortraitHandlingSizedBox(
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: BasicInformation._acresHeading,
          helperText: BasicInformation._acresDescription,
        ),
        initialValue: basicInfoData.acres.toString(),
        onChanged: (text) {
          if (text.isNotEmpty) {
            basicInfoData.acres = double.tryParse(text);
          }
        },
      ),
    );
  }

  /// Builds a Search bar to select a Landowner for the area.
  Widget _buildLandownerInput(BuildContext context) {
    final basicInfoData = Provider.of<BasicInfoDataModel>(context);

    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  BasicInformation._landownerHeading,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                ),
              ),
              SearchBar(
                controller: controller,
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                onSubmitted: (_) {},
                hintText: BasicInformation._landownerHint,
                leading: const Icon(Icons.search),
              ),
            ],
          ),
        );
      }, 
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return BasicInformation._landowners.map((name) {
          return ListTile(
            title: Text(name),
            onTap: () {}
          );
        });
      },
    );
  }

  /// Builds a text input field to enter the landowner's goals for the area.
  Widget _buildGoalsInput(BuildContext context) {
    final basicInfoData = Provider.of<BasicInfoDataModel>(context);

    return FreeTextBox(
      labelText: BasicInformation._goalsHeading,
      helperText: BasicInformation._goalDescription,
      initialValue: basicInfoData.goals,
      onChanged: (text) {
        basicInfoData.goals = text;
      }
    );
  }
}
