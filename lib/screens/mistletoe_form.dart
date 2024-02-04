import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/relative_sized_box.dart";

class MistletoeForm extends StatelessWidget {
  // Static variables ///////////////////////////////////////////////////
  static const _title = "Mistletoe Infections";
  // static const _buttonLabelPrev = "Previous"; // Commented out unused for linter.
  // static const _buttonLabelNext = "Next"; // Commented out unused for linter.
  static const _locationHeading = "Mistletoe location";

  // static const double _heightButton = 0.05; // Commented out unused for linter.
  static const double _heightHeading = 0.04;

  // Constructor //////////////////////////////////////////
  // Creates a screen with a form to enter data on mistletoe infections.
  const MistletoeForm({
    super.key,
  });

  // Methods ///////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Column(
        children: <Widget>[
          _buildLocationHeading(context),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter the mistletoe location(s)',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationHeading(BuildContext context) {
    return RelativeSizedBox(
      percentageHeight: _heightHeading,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          _locationHeading,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}