import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/screens/basic_information_form.dart";
import "package:forestryapp/screens/landowner_edit.dart";
import 'package:provider/provider.dart';
import "package:forestryapp/models/settings.dart";
import "package:forestryapp/screens/settings_edit.dart";


/// Landing page to help orient user when they open the app.
///
/// This is screen helps to direct the user (evaluator) to enter their contact
/// information as soon as possible as it is needed to create any area document
/// (PDF/DOCX). It also helps to convey the typical usage to the user as well.
class Home extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Home";
  static const _welcomeText = "Welcome to the Forest Wellness Checkup App!";
  static const _stepOneText = "Step 1: Enter your contact information.";
  static const _stepTwoText =
      "Step 2: Enter the landower's contact information.";
  static const _stepThreeText = "Step 3: Fill out the checklist.";
  static const _labelSettingsButton = "Update Settings";
  static const _labelLandowerButton = "Add New Landowner";
  static const _labelAreaButton = "Add New Area";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a the home page / introduction screen.
  const Home({
    super.key,
  });

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_welcomeText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/images/forestry_logo.png'),
                    width: 100, // Set the desired width
                    height: 100, // Set the desired height
                    fit: BoxFit.cover, // Maintain aspect ratio),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(_stepOneText,
                          style: Theme.of(context).textTheme.displaySmall),
                      _buildSettingsButton(context),
                    ],
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(_stepTwoText,
                          style: Theme.of(context).textTheme.displaySmall),
                      _buildLandownerButton(context),
                    ],
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(_stepThreeText,
                          style: Theme.of(context).textTheme.displaySmall),
                      _buildAreaButton(context),
                    ],
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlinedButton _buildSettingsButton(BuildContext context) {
    final settings = context.read<Settings>();

    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsEdit(
              settings: settings,
            ),
          ),
        );
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: const Text(_labelSettingsButton),
    );
  }

  OutlinedButton _buildLandownerButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LandownerEdit()),
        );
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: const Text(_labelLandowerButton),
    );
  }

  OutlinedButton _buildAreaButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Provider.of<Area>(context, listen: false).clearForNewForm();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BasicInformationForm()),
        );
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: const Text(_labelAreaButton),
    );
  }
}
