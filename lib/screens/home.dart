import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

class Home extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Home";
  static const _welcomeText = "Welcome to the Forest Wellness Checkup App!";
  static const _stepOneText = "Step 1: Enter your contact information.";
  static const _stepTwoText = "Step 2: Enter the landower's contact information.";
  static const _stepThreeText = "Step 3: Fill out the checklist.";

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
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_welcomeText, style: Theme.of(context).textTheme.displayMedium),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(image: AssetImage('assets/images/brand.png')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_stepOneText, style: Theme.of(context).textTheme.displaySmall),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_stepTwoText, style: Theme.of(context).textTheme.displaySmall),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_stepThreeText, style: Theme.of(context).textTheme.displaySmall),
              )),
            )
          ],
        ),
      ),
    );
  }
}
