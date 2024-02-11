import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/portrait_handling_sized_box.dart";

class BasicInformation extends StatefulWidget {
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

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen with a form to add name, landowner, and acres to the area.
  const BasicInformation({super.key});

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  // State /////////////////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _acresController;
  late final TextEditingController _goalsController;

  // Lifecycle Methods /////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _acresController = TextEditingController();
    _goalsController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _acresController.dispose();
    _goalsController.dispose();

    super.dispose();
  }

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: BasicInformation._title,
      body: FormScaffold(
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
    return PortraitHandlingSizedBox(
      child: FreeTextBox(
        controller: _nameController,
        labelText: BasicInformation._nameHeading,
        helperText: BasicInformation._nameDescription,
        onChanged: (text) {}
      ),
    );
  }

  /// Builds a numeric input field to enter the acres for the area.
  Widget _buildAcresInput(BuildContext context) {
    return PortraitHandlingSizedBox(
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: BasicInformation._acresHeading,
          helperText: BasicInformation._acresDescription,
        ),
        controller: _acresController,
      ),
    );
  }

  /// Builds a Search bar to select a Landowner for the area.
  Widget _buildLandownerInput(BuildContext context) {
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
                onSubmitted: (_) {
                  controller.closeView(controller.text);
                },
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
            onTap: () {
              setState(() {
                controller.closeView(name);
              });
            }
          );
        });
      },
    );
  }

  /// Builds a text input field to enter the landowner's goals for the area.
  Widget _buildGoalsInput(BuildContext context) {
    return FreeTextBox(
      controller: _goalsController,
      labelText: BasicInformation._goalsHeading,
      helperText: BasicInformation._goalDescription,
      onChanged: (text) {}
    );
  }
}
